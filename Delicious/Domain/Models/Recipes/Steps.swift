//
//  Steps.swift
//  Delicious
//
//  Created by HoaPQ on 7/7/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import ObjectMapper

struct Steps: Mappable {
	var number: Int = 0
	var step = ""
	var ingredients = [Ingredients]()
	var equipment = [String]()
    
    init() {
        
    }

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		number <- map["number"]
		step <- map["step"]
		ingredients <- map["ingredients"]
		equipment <- map["equipment"]
	}

}
