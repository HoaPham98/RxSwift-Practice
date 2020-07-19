//
//  RecipeInfoNavigator.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

protocol RecipeInfoNavigatorType {
    func showDeletionConfirm(recipe: FavoriteRecipe) -> Observable<FavoriteRecipe>
}

struct RecipeInfoNavigator: RecipeInfoNavigatorType {
    unowned let navigationController: UINavigationController
    
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
