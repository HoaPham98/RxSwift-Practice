//
//  StepTBCell.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable

class StepTBCell: UITableViewCell, NibReusable {

    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp(data: Steps) {
        stepLabel.text = "\(data.number)"
        label.text = data.step
    }
    
}
