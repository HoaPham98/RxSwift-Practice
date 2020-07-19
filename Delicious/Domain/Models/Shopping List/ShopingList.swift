//
//  ShopingList.swift
//  Delicious
//
//  Created by HoaPQ on 7/15/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

struct ShopingList {
    let id: Int
    let title: String
    var ingredients: [ShortIngredient]
    
    init(id: Int, title: String, ingredients: [ShortIngredient]) {
        self.id = id
        self.title = title
        self.ingredients = ingredients
    }
    
    init(from recipe: RecipeInformation) {
        id = recipe.id
        title = recipe.title
        ingredients = recipe.extendedIngredients.map { ShortIngredient(from: $0) }
    }
}

extension ShopingList: CoreDataModel {
    static var primaryKey: String {
        return "id"
    }
    
    var modelID: Int {
        return id
    }
}
