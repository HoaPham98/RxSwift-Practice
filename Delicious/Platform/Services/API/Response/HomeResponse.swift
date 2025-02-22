//
//  HomeResponse.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import ObjectMapper

struct HomeResponse: Mappable {
    var recipes = [RecipeInformation]()
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        recipes <- map["recipes"]
    }
}
