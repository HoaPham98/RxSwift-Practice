//
//  RecipeHeaderView.swift
//  Delicious
//
//  Created by HoaPQ on 7/11/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable

class RecipeHeaderView: UIView, NibOwnerLoadable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
}
