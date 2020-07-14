//
//  NutritionTBCell.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable

class NutritionTBCell: UITableViewCell, NibReusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dailyNeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: Nutrients) {
        nameLabel.text = data.title
        valueLabel.text = "\(data.amount)/\(data.percentOfDailyNeeds) \(data.unit)"
        dailyNeedLabel.text = ""
        if data.amount > data.percentOfDailyNeeds {
            valueLabel.textColor = .systemRed
            dailyNeedLabel.textColor = .systemGreen
        } else {
            valueLabel.textColor = .systemGreen
            dailyNeedLabel.textColor = nameLabel.textColor
        }
    }
    
}
