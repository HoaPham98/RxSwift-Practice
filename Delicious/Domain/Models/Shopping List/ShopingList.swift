//
//  ShopingList.swift
//  Delicious
//
//  Created by HoaPQ on 7/15/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

struct ShopingList: RecipeType {
    var id: Int
    var title: String
    var readyInMinutes: Int
    var servings: Int
    var image: String
    var creditsText: String
    var ingredients: [ShortIngredient]
    
    init(id: Int, title: String, readyInMinutes: Int, servings: Int, image: String, creditsText: String, ingredients: [ShortIngredient]) {
        self.id = id
        self.title = title
        self.readyInMinutes = readyInMinutes
        self.servings = servings
        self.image = image
        self.creditsText = creditsText
        self.ingredients = ingredients
    }

    init(from recipe: RecipeInformation) {
        id = recipe.id
        title = recipe.title
        readyInMinutes = recipe.readyInMinutes
        servings = recipe.servings
        image = recipe.image
        creditsText = recipe.creditsText
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
