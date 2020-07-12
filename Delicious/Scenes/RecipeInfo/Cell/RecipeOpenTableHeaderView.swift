//
//  RecipeOpenTableHeaderView.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable

final class RecipeOpenTableHeaderView: UIView, NibLoadable {

  //UI Properties
    @IBOutlet weak var headerLabel: UILabel!
    
    func setUp(title: String) {
        headerLabel.text = title
    }
}
