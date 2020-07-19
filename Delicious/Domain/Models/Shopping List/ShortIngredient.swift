//
//  ShortIngredient.swift
//  Delicious
//
//  Created by HoaPQ on 7/15/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import RxDataSources

public struct ShortIngredient {
    let id: Int
    let title: String
    let amount: Double
    let unit: String
    var isDone = false
    
    init(id: Int, title: String, amount: Double, unit: String, isDone: Bool) {
        self.id = id
        self.title = title
        self.amount = amount
        self.unit = unit
        self.isDone = isDone
    }
    
    init(from ingredient: ExtendedIngredients) {
        id = ingredient.id
        title = ingredient.name
        amount = ingredient.amount
        unit = ingredient.unit
        isDone = false
    }
    
    func toClass() -> NSShortIngredient {
        return NSShortIngredient(id: id, title: title, amount: amount, unit: unit, isDone: isDone)
    }
}
