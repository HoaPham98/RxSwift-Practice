//
//  FavoriteViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

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
        }
    }

    func bindViewModel() {
        let input = FavoriteViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: tableView.loadMoreTopTrigger,
            deletedTrigger: tableView.rx.modelDeleted(FavoriteRecipe.self).asDriver(),
            selectedTrigger: tableView.rx.modelSelected(FavoriteRecipe.self).asDriver())

        let output = viewModel.transform(input)
        output.data.drive(tableView.rx.items) { tableView, index, recipe in
            let indexPath = IndexPath(row: index, section: 0)
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RecipeTBCell.self)
            cell.setInfo(recipe: recipe)
            return cell
        }.disposed(by: rx.disposeBag)
        output.isLoading.drive(rx.isLoading).disposed(by: rx.disposeBag)
        output.isReloading.drive(tableView.isLoadingMoreTop).disposed(by: rx.disposeBag)
        output.error.drive(rx.error).disposed(by: rx.disposeBag)
        output.deleted.drive(loadTrigger).disposed(by: rx.disposeBag)
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
