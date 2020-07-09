//
//  AnalyzedInstructions.swift
//  Delicious
//
//  Created by HoaPQ on 7/7/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import ObjectMapper

struct AnalyzedInstructions: Mappable {
	var name = ""
	var steps = [Steps]()
    
    init() {
        
    }

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		name <- map["name"]
		steps <- map["steps"]
	}

}
