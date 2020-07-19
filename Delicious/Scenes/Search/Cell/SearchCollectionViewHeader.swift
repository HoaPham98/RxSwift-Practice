//
//  SearchCollectionViewHeader.swift
//  Delicious
//
//  Created by HoaPQ on 7/19/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

class SearchCollectionViewHeader: UICollectionReusableView, NibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
