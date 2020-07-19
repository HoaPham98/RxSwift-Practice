//
//  TagCollectionViewCell.swift
//  Delicious
//
//  Created by HoaPQ on 7/18/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.do {
            $0.applyCornerRadius(radius: 15)
        }
    }

    func setData(text: String) {
        textLabel.text = text.capitalized
    }
}
