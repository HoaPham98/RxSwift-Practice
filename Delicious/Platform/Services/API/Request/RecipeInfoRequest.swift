//
//  RecipeInfoRequest.swift
//  Delicious
//
//  Created by HoaPQ on 7/12/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

class RecipeInfoRequest: BaseRequest {
    var id: Int
    init(id: Int) {
        self.id = id
        super.init(url: "")
    }
}
