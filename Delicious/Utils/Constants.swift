//
//  Constants.swift
//  Delicious
//
//  Created by HoaPQ on 7/7/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

enum Icon {
    static let icHomeNormal = #imageLiteral(resourceName: "ic_home_grey")
    static let icHomeSelected = #imageLiteral(resourceName: "ic_home_orange")
    
    static let icSearch = #imageLiteral(resourceName: "ic_search")
    static let icBack = #imageLiteral(resourceName: "ic_arrow_back")
    
    static let recipePlaceHolder = #imageLiteral(resourceName: "recipe_placeholder")
}

enum Constant {
    static let topOffset = UIApplication.shared.windows.first{ $0.isKeyWindow }?.safeAreaInsets.top
}
