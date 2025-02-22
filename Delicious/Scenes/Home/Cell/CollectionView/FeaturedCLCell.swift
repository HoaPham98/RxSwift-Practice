//
//  FeaturedCLCell.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable

final class FeaturedCLCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.applyCornerRadius(radius: 24)
    }
    
    func setInfo(with recipe: RecipeInformation) {
        imageView.sd_setImage(
            with: URL(string: recipe.image),
            placeholderImage: Icon.recipePlaceHolder,
            context: nil)
    }

}
