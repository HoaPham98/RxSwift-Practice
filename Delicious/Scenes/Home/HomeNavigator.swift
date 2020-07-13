//
//  HomeNavigator.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

protocol HomeNavigatorType {
    func toInfomation(recipe: RecipeType)
    func toSearch()
}

struct HomeNavigator: HomeNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toInfomation(recipe: RecipeType) {
        let recipeInfoVC = RecipeInfoViewController.instantiate()
        let navigator = RecipeInfoNavigator()
        let useCase = RecipeInfoUseCase()
        let viewModel = RecipeInfoViewModel(navigator: navigator, useCase: useCase, recipe: recipe)
        recipeInfoVC.bindViewModel(to: viewModel)
        
        navigationController.pushViewController(recipeInfoVC, animated: true)
    }
    
    func toSearch() {
        // TODO: Go to Search Screen
    }
}
