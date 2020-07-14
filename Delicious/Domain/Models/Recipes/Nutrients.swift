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
	var title = ""
	var amount: Double = 0
	var unit = ""
    var percentOfDailyNeeds: Double = 0

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		title <- map["title"]
		amount <- map["amount"]
		unit <- map["unit"]
        percentOfDailyNeeds <- map["percentOfDailyNeeds"]
	}

}
