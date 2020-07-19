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
    func showDeletionConfirm(recipe: FavoriteRecipe) -> Observable<FavoriteRecipe>
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toInfomation(recipe: RecipeType) {
        let recipeInfoVC = RecipeInfoViewController.instantiate()
        let navigator = RecipeInfoNavigator(navigationController: navigationController)
        let useCase = RecipeInfoUseCase()
        let viewModel = RecipeInfoViewModel(navigator: navigator, useCase: useCase, recipe: recipe)
        recipeInfoVC.bindViewModel(to: viewModel)
        
        navigationController.pushViewController(recipeInfoVC, animated: true)
    }
    
    func showDeletionConfirm(recipe: FavoriteRecipe) -> Observable<FavoriteRecipe> {
        let message = "Are you sure you want to remove this recipe from Favorite?"
        return navigationController
            .showAlertView(title: "Remove confirm",
                           message: message,
                           style: .alert,
                           actions: [("Yes", .default),
                                     ("Cancel", .cancel)])
            .filter { $0 == 0 }
            .map { _ in recipe }
    }
}
