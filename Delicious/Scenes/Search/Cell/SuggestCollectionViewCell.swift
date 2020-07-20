//
//  SuggestCollectionViewCell.swift
//  Delicious
//
//  Created by HoaPQ on 7/20/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

class SuggestCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp(_ text: String) {
        textLabel.text = text
    }
}
