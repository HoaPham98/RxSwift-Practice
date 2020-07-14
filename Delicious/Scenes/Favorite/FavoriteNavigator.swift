//
//  FavoriteNavigator.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

protocol FavoriteNavigatorType {
    func toInfomation(recipe: RecipeType)
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toInfomation(recipe: RecipeType) {
        let recipeInfoVC = RecipeInfoViewController.instantiate()
        let navigator = RecipeInfoNavigator()
        let useCase = RecipeInfoUseCase()
        let viewModel = RecipeInfoViewModel(navigator: navigator, useCase: useCase, recipe: recipe)
        recipeInfoVC.bindViewModel(to: viewModel)
        
        navigationController.pushViewController(recipeInfoVC, animated: true)
    }
}
