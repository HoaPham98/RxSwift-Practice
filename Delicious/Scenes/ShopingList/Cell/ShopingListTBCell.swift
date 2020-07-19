//
//  ShopingListTBCell.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable

class ShopingListTBCell: UITableViewCell, NibReusable {

    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp(short: ShortIngredient) {
        amountLabel.text = "\(short.amount) \(short.unit)"
        ingredientLabel.attributedText = short.title.capitalized.strikedThrough(short.isDone)
        layoutIfNeeded()
    }
    
}

extension String {
    func strikedThrough(_ isOn: Bool) -> NSAttributedString {
        if isOn {
            let strikethroughStyle = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            return NSAttributedString(string: self, attributes: strikethroughStyle)
        } else {
            return NSAttributedString(string: self)
        }
    }
}
