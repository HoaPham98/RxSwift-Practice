//
//  Ingredients.swift
//  Delicious
//
//  Created by HoaPQ on 7/7/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import ObjectMapper

struct Ingredients: Mappable {
	var id: Int = 0
	var name = ""
	var localizedName = ""
	var image = ""
    
    init() {
        
    }

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		id <- map["id"]
		name <- map["name"]
		localizedName <- map["localizedName"]
		image <- map["image"]
	}

}
