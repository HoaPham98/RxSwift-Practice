//
//  Constants.swift
//  Delicious
//
//  Created by HoaPQ on 7/7/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

enum Icon {
    static let icHomeNormal = #imageLiteral(resourceName: "ic_home_grey")
    static let icHomeSelected = #imageLiteral(resourceName: "ic_home_orange")
    
    static let icSearch = #imageLiteral(resourceName: "ic_search")
    static let icBack = #imageLiteral(resourceName: "ic_arrow_back")
    
    static let recipePlaceHolder = #imageLiteral(resourceName: "recipe_placeholder")
    
    static let icFavoriteSelected = #imageLiteral(resourceName: "ic_favorites_grey")
    static let icFavorite = #imageLiteral(resourceName: "ic_favorite")
    static let icFavoriteSelectedOrange = #imageLiteral(resourceName: "ic_favorites_orange")
    
    static let icShoping = #imageLiteral(resourceName: "ic_recipes_grey2")
    static let icShopingSelected = #imageLiteral(resourceName: "ic_recipes_orange")
}

enum SearchTag {
    case recent(String)
    case type(String)
    case cuisine(String)
    case diet(String)
    
    var textString: String {
        switch self {
        case .cuisine(let text):
            return text
        case .type(let text):
            return text
        case .recent(let text):
            return text
        case .diet(let text):
            return text
        }
    }
    
    var typeString: String {
        switch self {
        case .recent:
            return "Recent"
        case .type:
            return "Meal Types"
        case .cuisine:
            return "Cuisines"
        case .diet:
            return "Diets"
        }
    }
    
    static let mealTypes = [
        "main course",
        "side dish",
        "dessert",
        "appetizer",
        "salad",
        "bread",
        "breakfast",
        "soup",
        "beverage",
        "sauce",
        "marinade",
        "fingerfood",
        "snack",
        "drink"
    ]
    static let cuisines = [
        "African",
        "American",
        "British",
        "Cajun",
        "Caribbean",
        "Chinese",
        "Eastern European",
        "European",
        "Indian",
        "Italian",
        "Japanese",
        "Korean",
        "Mexican",
        "Middle Eastern",
        "Nordic",
        "Southern",
        "Spanish",
        "Thai",
        "Vietnamese"
    ]
    static let diets = [
        "Gluten Free",
        "Ketogenic",
        "Vegetarian",
        "Lacto-Vegetarian",
        "Ovo-Vegetarian",
        "Vegan",
        "Pescetarian",
        "Paleo",
        "Primal",
        "Whole30"
    ]
}

enum Constant {
    static let kMaxRecentSize = 5
    static let kRecentSearch = "kRecentSearch"
    static let kRecentRecipe = "kRecentRecipe"
}
