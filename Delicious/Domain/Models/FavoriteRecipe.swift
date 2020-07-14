//
//  FavoriteRecipe.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

struct FavoriteRecipe: RecipeType {
    var id: Int
    var title: String
    var readyInMinutes: Int
    var servings: Int
    var image: String
    var creditsText: String
}

extension FavoriteRecipe: CoreDataModel {
    static var primaryKey: String {
        return "id"
    }
    
    var modelID: Int {
        return id
    }
}
