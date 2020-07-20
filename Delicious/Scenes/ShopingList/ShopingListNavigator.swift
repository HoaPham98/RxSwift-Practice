//
//  ShopingListNavigator.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

protocol ShopingListNavigatorType {
    func showDeletionConfirm(list: ShopingList) -> Observable<ShopingList>
    func toInformation(recipe: RecipeType)
}

struct ShopingListNavigator: ShopingListNavigatorType {
    unowned let navigationController: UINavigationController
    
    func showDeletionConfirm(list: ShopingList) -> Observable<ShopingList> {
        let message = "Are you sure you want to remove this recipe from ShopingList?"
        return navigationController
            .showAlertView(title: "Remove confirm",
                           message: message,
                           style: .alert,
                           actions: [("Yes", .default),
                                     ("Cancel", .cancel)])
            .filter { $0 == 0 }
            .map { _ in list }
    }
    
    func toInformation(recipe: RecipeType) {
        let recipeInfoVC = RecipeInfoViewController.instantiate()
        let navigator = RecipeInfoNavigator(navigationController: navigationController)
        let useCase = RecipeInfoUseCase()
        let viewModel = RecipeInfoViewModel(navigator: navigator, useCase: useCase, recipe: recipe)
        recipeInfoVC.bindViewModel(to: viewModel)
        
        navigationController.pushViewController(recipeInfoVC, animated: true)
    }
}
