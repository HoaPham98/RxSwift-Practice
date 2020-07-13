//
//  RecipeHeaderView.swift
//  Delicious
//
//  Created by HoaPQ on 7/13/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class RecipeHeaderView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var recipe: Binder<RecipeType> {
        return Binder(self) { (view, data) in
            view.do {
                $0.creditsLabel.text = data.creditsText
                $0.titleLabel.text = data.title
                $0.imageView.sd_setImage(with: URL(string: data.image), completed: nil)
                $0.timeLabel.text = String(format: "%d minutes", data.readyInMinutes)
                $0.difficultyLabel.text = Helpers.timeToDificulty(with: data.readyInMinutes)
                $0.servingsLabel.text = String(format: "%d people", data.servings)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
