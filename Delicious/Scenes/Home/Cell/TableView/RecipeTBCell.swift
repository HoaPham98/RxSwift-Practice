//
//  RecipeTBCell.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class RecipeTBCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timeToCookLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var servingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setInfo(recipe: RecipeInformation) {
        recipeImage.sd_setImage(with: URL(string: recipe.image), completed: nil)
        categoryLabel.text = recipe.creditsText
        recipeNameLabel.text = recipe.title
        timeToCookLabel.text = String(format: "%d minutes", recipe.readyInMinutes)
        difficultyLabel.text = Helpers.timeToDificulty(with: recipe.readyInMinutes)
        servingLabel.text = String(format: "%d people", recipe.servings)
    }
    
}
