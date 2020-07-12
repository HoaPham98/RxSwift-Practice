//
//  HomeViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import NSObject_Rx
import MGArchitecture
import MGLoadMore
import Reusable
import RxDataSources

final class HomeViewController: UIViewController, BindableType {
    @IBOutlet weak private var tableView: RefreshTableView!

    var viewModel: HomeViewModel!

    private let selectedCLTrigger = PublishSubject<RecipeInformation?>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configView()
        configTableView()
    }

    func configView() {
        navigationItem.title = "Delicous"
    }

    func configTableView() {
        tableView.do {
            $0.register(cellType: FeaturedTBCell.self)
            $0.register(cellType: RecipeTBCell.self)
            $0.estimatedRowHeight = UITableView.automaticDimension
            $0.refreshFooter = nil
            $0.rx.setDelegate(self).disposed(by: rx.disposeBag)
        }
    }

    func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<HomeTableViewSection>(configureCell: { [weak self] (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .featuredItem(let recipes):
                let cell = tableView.dequeueReusableCell(
                                for: indexPath,
                                cellType: FeaturedTBCell.self).then {
                                    $0.setData(data: recipes)
                                    $0.selectedRecipe = {
                                        self?.selectedCLTrigger.onNext($0)
                                    }
                }
                return cell
            case .lastestItem(let recipe):
                let cell = tableView.dequeueReusableCell(
                                for: indexPath,
                                cellType: RecipeTBCell.self)
                            cell.setInfo(recipe: recipe)
                return cell
            }
        })
        
        let input = HomeViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: tableView.loadMoreTopTrigger,
            selectTrigger: selectedCLTrigger.asDriver(onErrorJustReturn: nil))
        
        let output = viewModel.transform(input)
        
        output.isLoading.drive(rx.isLoading).disposed(by: rx.disposeBag)
        output.isReloading.drive(tableView.isLoadingMoreTop).disposed(by: rx.disposeBag)
        output.error.drive(rx.error).disposed(by: rx.disposeBag)
        output.selected.drive().disposed(by: rx.disposeBag)
        output.data.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)

        tableView.rx.modelSelected(HomeTableViewItem.self).compactMap { (item) -> RecipeInformation? in
            switch item {
            case .lastestItem(let recipe):
                return recipe
            default:
                return nil
            }
        }.bind(to: selectedCLTrigger).disposed(by: rx.disposeBag)
        
//        selectedCLTrigger.onNext(RecipeInformation())
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeTableHeaderView.loadFromNib()
        header.setUp(title: section == 0 ? "FEATURED" : "LASTEST")

        return header
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.home
}
