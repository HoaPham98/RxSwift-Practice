//
//  RecipeInformation.swift
//  Delicious
//
//  Created by HoaPQ on 7/7/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

protocol RecipeType {
    var id: Int { get set }
    var title: String { get set }
    var readyInMinutes: Int { get set }
    var servings: Int { get set }
    var image: String { get set }
    var creditsText: String { get set }
}

extension RecipeType {
    func mapToFavorite() -> FavoriteRecipe {
        return FavoriteRecipe(
            id: self.id,
            title: self.title,
            readyInMinutes: self.readyInMinutes,
            servings: self.servings,
            image: self.image,
            creditsText: self.creditsText
        )
    }
}

struct RecipeInformation: Mappable, RecipeType, IdentifiableType, Equatable {
	var vegetarian = false
	var vegan = false
	var glutenFree = false
	var dairyFree = false
	var veryHealthy = false
	var cheap = false
	var veryPopular = false
	var sustainable = false
	var weightWatcherSmartPoints: Int = 0
	var gaps = ""
	var lowFodmap = false
	var aggregateLikes: Int = 0
	var spoonacularScore: Double = 0
	var healthScore: Double = 0
	var creditsText = ""
	var sourceName = ""
	var pricePerServing: Double = 0
	var extendedIngredients = [ExtendedIngredients]()
	var id: Int = 0
	var title = ""
	var readyInMinutes: Int = 0
	var servings: Int = 0
	var sourceUrl = ""
	var image = ""
	var imageType = ""
	var nutrition = Nutrition()
	var summary = ""
	var cuisines = [String]()
	var dishTypes = [String]()
	var diets = [String]()
	var occasions = [String]()
	var winePairing = WinePairing()
	var instructions = ""
	var analyzedInstructions = [AnalyzedInstructions]()
	var originalId = ""
    var identity: Int {
        return id
    }
    
    init() {
        
    }

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		vegetarian <- map["vegetarian"]
		vegan <- map["vegan"]
		glutenFree <- map["glutenFree"]
		dairyFree <- map["dairyFree"]
		veryHealthy <- map["veryHealthy"]
		cheap <- map["cheap"]
		veryPopular <- map["veryPopular"]
		sustainable <- map["sustainable"]
		weightWatcherSmartPoints <- map["weightWatcherSmartPoints"]
		gaps <- map["gaps"]
		lowFodmap <- map["lowFodmap"]
		aggregateLikes <- map["aggregateLikes"]
		spoonacularScore <- map["spoonacularScore"]
		healthScore <- map["healthScore"]
		creditsText <- map["creditsText"]
		sourceName <- map["sourceName"]
		pricePerServing <- map["pricePerServing"]
		extendedIngredients <- map["extendedIngredients"]
		id <- map["id"]
		title <- map["title"]
		readyInMinutes <- map["readyInMinutes"]
		servings <- map["servings"]
		sourceUrl <- map["sourceUrl"]
		image <- map["image"]
		imageType <- map["imageType"]
		nutrition <- map["nutrition"]
		summary <- map["summary"]
		cuisines <- map["cuisines"]
		dishTypes <- map["dishTypes"]
		diets <- map["diets"]
		occasions <- map["occasions"]
		winePairing <- map["winePairing"]
		instructions <- map["instructions"]
		analyzedInstructions <- map["analyzedInstructions"]
		originalId <- map["originalId"]
	}
    
    static func == (lhs: RecipeInformation, rhs: RecipeInformation) -> Bool {
        return lhs.id == rhs.id
    }
}
