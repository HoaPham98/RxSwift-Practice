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

final class HomeViewController: UIViewController, BindableType {
    @IBOutlet weak private var tableView: RefreshTableView!

    var viewModel: HomeViewModel!

    private var data = BehaviorRelay<HomeDataType?>(value: nil)
    private let selectedCLTrigger = PublishSubject<RecipeInformation>()

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
            $0.delegate = self
            $0.dataSource = self
            $0.refreshFooter = nil
        }
    }

    func bindViewModel() {
        let input = HomeViewModel.Input(
            loadTrigger: Driver.of(),
            reloadTrigger: tableView.loadMoreTopTrigger,
            selectTrigger: selectedCLTrigger.asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input)
        
        output.isLoading.drive(rx.isLoading).disposed(by: rx.disposeBag)
        output.isReloading.drive(tableView.isLoadingMoreTop).disposed(by: rx.disposeBag)
        output.error.drive(rx.error).disposed(by: rx.disposeBag)
        output.selected.drive().disposed(by: rx.disposeBag)
        output.data.drive(data).disposed(by: rx.disposeBag)

        data.observeOn(MainScheduler.instance).subscribe { _ in
            self.tableView.reloadData()
        }.disposed(by: rx.disposeBag)
        
        selectedCLTrigger.onNext(RecipeInformation())
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.home
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.value == nil ? 0 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data.value else { return 0 }
        return section == 0 ? 1 : data.lastest.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: FeaturedTBCell.self).then {
                $0.setCollectionViewDataSourceDelegate(dataSourceDelegate: self)
            }

            return cell
        default:
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: RecipeTBCell.self)
            cell.setInfo(recipe: data.value!.lastest[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeTableHeaderView.loadFromNib()
        header.setUp(title: section == 0 ? "FEATURED" : "LASTEST")

        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 { return }
        selectedCLTrigger.onNext(data.value!.lastest[indexPath.row])
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data.value {
            return data.featured.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FeaturedCLCell.self)
        cell.setInfo(with: data.value!.featured[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCLTrigger.onNext(data.value!.featured[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 160
        let width = height / 393 * 636
        return CGSize(width: width, height: height)
    }
}
