//
//  RecipeInfoViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
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

final class RecipeInfoViewController: UIViewController, BindableType {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RecipeInfoViewModel!
    
    private var recipeId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
    }
    
    func setUpData(id: Int) {
        recipeId = id
    }
    
    func configViews() {
        hideBackTitle()
        
        tableView.do {
            $0.register(cellType: RecipeInfoTBCell.self)
            $0.register(cellType: IngredientTBCell.self)
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    private func hideBackTitle() {
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
    }
    
    func bindViewModel() {
        
    }
}

extension RecipeInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RecipeInfoTBCell.self)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: IngredientTBCell.self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = RecipeOpenTableHeaderView.loadFromNib()
        return section == 0 ? UIView() : header
    }
}

extension RecipeInfoViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = StoryBoards.recipeInfo
}
