//
//  FavoriteViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import RxDataSources

class FavoriteViewController: UIViewController, BindableType {
    @IBOutlet weak var tableView: RefreshTableView!

    private let loadTrigger = PublishSubject<Void>()

    var viewModel: FavoriteViewModel!

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
            $0.register(cellType: RecipeTBCell.self)
            $0.refreshFooter = nil
        }
    }

    func bindViewModel() {
        let dataSource = RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .right,
                                                           reloadAnimation: .none,
                                                           deleteAnimation: .left),
            configureCell: { _, tableView, indexPath, recipe in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RecipeTBCell.self)
                cell.setInfo(recipe: recipe)
                return cell
            },
            canEditRowAtIndexPath: { _, _ in
                return true
            }
        )

        let input = FavoriteViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: tableView.loadMoreTopTrigger,
            deletedTrigger: tableView.rx.modelDeleted(FavoriteRecipe.self).asDriver(),
            selectedTrigger: tableView.rx.modelSelected(FavoriteRecipe.self).asDriver())

        let output = viewModel.transform(input)
        output.data.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.isLoading.drive(rx.isLoading).disposed(by: rx.disposeBag)
        output.isReloading.drive(tableView.isLoadingMoreTop).disposed(by: rx.disposeBag)
        output.error.drive(rx.error).disposed(by: rx.disposeBag)
        output.deleted.drive(loadTrigger).disposed(by: rx.disposeBag)
        output.selected.drive().disposed(by: rx.disposeBag)
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoriteViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = StoryBoards.favorite
}
