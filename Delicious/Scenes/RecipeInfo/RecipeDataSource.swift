//
//  RecipeDataSource.swift
//  Delicious
//
//  Created by HoaPQ on 7/13/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxDataSources

enum RecipeTableViewItem {
    case nutrientItem(item: Nutrients)
    case ingredientItem(item: ExtendedIngredients)
    case stepItem(item: Steps)
}

enum RecipeTableViewSection {
    case nutrientItem(item: RecipeInformation)
    case ingredientItem(item: RecipeInformation)
    case stepItem(item: AnalyzedInstructions)
}

extension RecipeTableViewSection: SectionModelType {
    typealias Item = RecipeTableViewItem

    var header: String {
        return ""
    }
    
    var items: [RecipeTableViewItem] {
        switch self {
        case .nutrientItem(let recipe):
            return recipe.nutrition.nutrients.map { RecipeTableViewItem.nutrientItem(item: $0)}
        case .ingredientItem(let recipe):
            return recipe.extendedIngredients.map { RecipeTableViewItem.ingredientItem(item: $0)}
        case .stepItem(let item):
            return item.steps.map { RecipeTableViewItem.stepItem(item: $0) }
        }
    }
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}
