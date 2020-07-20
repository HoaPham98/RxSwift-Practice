//
//  Helpers.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

enum Helpers {
    static func timeToDificulty(with time: Int) -> String {
        if time < 20 {
            return "Easy"
        } else if time < 30 {
            return "Medium"
        } else {
            return "Hard"
        }
    }
    
    static var statusBarSize: CGSize?
    static var safeAreaInsets: UIEdgeInsets?
    
    static var recentSearch: LimitedArray<String> {
        get {
            return UserDefaults.standard.object(forKey: Constant.kRecentRecipe) as? LimitedArray<String> ?? LimitedArray<String>(maxSize: Constant.kMaxRecentSize)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constant.kRecentRecipe)
        }
    }
}
