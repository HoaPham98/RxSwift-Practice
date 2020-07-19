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
            $0.rx.setDelegate(self).disposed(by: self.rx.disposeBag)
        }
    }

    func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<ShopingListSectionModel>(
//            animationConfiguration: AnimationConfiguration(insertAnimation: .right,
//                                                           reloadAnimation: .none,
//                                                           deleteAnimation: .left),
            configureCell: { _, tableView, indexPath, ingredient in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ShopingListTBCell.self)
                cell.setUp(short: ingredient)
                return cell
            },
            titleForHeaderInSection: { (section, index) in
                return section.sectionModels[index].model
            }
        )

        let input = ShopingListViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: tableView.loadMoreTopTrigger,
            selectedTrigger: tableView.rx.itemSelected.asDriver()
        )

        let output = viewModel.transform(input)
        output.data.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.isLoading.drive(rx.isLoading).disposed(by: rx.disposeBag)
        output.isReloading.drive(tableView.isLoadingMoreTop).disposed(by: rx.disposeBag)
        output.error.drive(rx.error).disposed(by: rx.disposeBag)
        output.selected.drive(loadTrigger).disposed(by: rx.disposeBag)
    }
}

extension ShopingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ShopingListViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = StoryBoards.shoppingList
}
