//
//  IngredientTBCell.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable

class IngredientTBCell: UITableViewCell, NibReusable {

    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp(data: ExtendedIngredients) {
        ingredientLabel.text = data.originalString
    }
    
}
