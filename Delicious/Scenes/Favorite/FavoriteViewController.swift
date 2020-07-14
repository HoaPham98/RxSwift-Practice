//
//  FavoriteViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, BindableType {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FavoriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
    }
    
    private func configViews() {
        tableView.do {
            $0.register(cellType: RecipeTBCell.self)
        }
    }
    
    func bindViewModel() {
        let input = FavoriteViewModel.Input(
            loadTrigger: Driver.just(()),
            selectedTrigger: tableView.rx.modelSelected(FavoriteRecipe.self).asDriver(),
            deletedTrigger: Driver.of())
        
        let output = viewModel.transform(input)
        output.recipes.drive(tableView.rx.items) { tableView, index, recipe in
            let indexPath = IndexPath(row: index, section: 0)
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RecipeTBCell.self)
            cell.setInfo(recipe: recipe)
            return cell
        }.disposed(by: rx.disposeBag)
        output.selected.drive().disposed(by: rx.disposeBag)
    }
}

extension FavoriteViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = StoryBoards.favorite
}
