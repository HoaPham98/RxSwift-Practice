//
//  Measures.swift
//  Delicious
//
//  Created by HoaPQ on 7/7/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import ObjectMapper

struct Measures: Mappable {
	var us = Us()
	var metric = Metric()
    
    init() {
        
    }

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		us <- map["us"]
		metric <- map["metric"]
	}
}
