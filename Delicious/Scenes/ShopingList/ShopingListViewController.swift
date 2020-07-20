//
//  ShopingListViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import RxDataSources

class ShopingListViewController: UIViewController, BindableType {
    @IBOutlet weak var tableView: RefreshTableView!

    private let loadTrigger = PublishSubject<Void>()
    private let selectTitleTrigger = PublishSubject<RecipeType>()
    private let deleteTrigger = PublishSubject<ShopingList>()
    var dataSource: RxTableViewSectionedReloadDataSource<ShopingListSectionModel>!

    var viewModel: ShopingListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTrigger.onNext(())
    }

    private func configViews() {
        tableView.do {
            $0.register(cellType: ShopingListTBCell.self)
            $0.refreshFooter = nil
            $0.sectionHeaderHeight = UITableView.automaticDimension
            $0.estimatedSectionHeaderHeight = 38
            $0.rx.setDelegate(self).disposed(by: self.rx.disposeBag)
        }
    }

    func bindViewModel() {
        dataSource = RxTableViewSectionedReloadDataSource<ShopingListSectionModel>(
            configureCell: { _, tableView, indexPath, ingredient in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ShopingListTBCell.self)
                cell.setUp(short: ingredient)
                return cell
            }
        )

        let input = ShopingListViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: tableView.loadMoreTopTrigger,
            selectedTrigger: tableView.rx.itemSelected.asDriver(),
            selectedTitleTrigger: selectTitleTrigger.asDriverOnErrorJustComplete(),
            deleteTrigger: deleteTrigger.asDriverOnErrorJustComplete()
        )

        let output = viewModel.transform(input)
        output.data.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.isLoading.drive(rx.isLoading).disposed(by: rx.disposeBag)
        output.isReloading.drive(tableView.isLoadingMoreTop).disposed(by: rx.disposeBag)
        output.error.drive(rx.error).disposed(by: rx.disposeBag)
        output.selected.drive(loadTrigger).disposed(by: rx.disposeBag)
        output.selectedTitle.drive().disposed(by: rx.disposeBag)
        output.deleted.drive(loadTrigger).disposed(by: rx.disposeBag)
    }
}

extension ShopingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ShopingListHeaderView.loadFromNib()
        let shopingList = dataSource.sectionModels[section].model
        header.setUp(recipe: shopingList)
        header.tapTitle = { [weak self] recipe in
            self?.selectTitleTrigger.onNext(recipe)
        }
        header.tapRemove = { [weak self] shoppingList in
            self?.deleteTrigger.onNext(shoppingList)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ShopingListViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = StoryBoards.shoppingList
}
