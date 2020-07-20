//
//  ShopingListHeaderView.swift
//  Delicious
//
//  Created by HoaPQ on 7/20/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

class ShopingListHeaderView: UIView, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var removeImage: UIImageView!
    
    var tapTitle: ((RecipeType) -> Void)?
    var tapRemove: ((ShopingList) -> Void)?
    private var data: ShopingList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.addTapGesture(target: self, action: #selector(onTitleTap))
        removeImage.addTapGesture(target: self, action: #selector(onRemoveTap))
    }
    
    func setUp(recipe: ShopingList) {
        data = recipe
        titleLabel.text = recipe.title
    }
    
    @objc private func onTitleTap() {
        if let data = data {
            tapTitle?(data)
        }
    }
    
    @objc private func onRemoveTap() {
        if let data = data {
            tapRemove?(data)
        }
    }
}
