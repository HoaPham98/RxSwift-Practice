//
//  Nutrients.swift
//  Delicious
//
//  Created by HoaPQ on 7/7/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import ObjectMapper

struct Nutrients: Mappable {
	var name = ""
	var amount: Double = 0
	var unit = ""

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		name <- map["name"]
		amount <- map["amount"]
		unit <- map["unit"]
	}

}
