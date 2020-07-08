//
//  HomeTableHeaderView.swift
//  FLAVR
//
//  Created by Chidi Emeh on 7/9/17.
//  Copyright © 2017 Chilly Bean. All rights reserved.
//

import UIKit
import Reusable

final class HomeTableHeaderView: UIView, NibLoadable {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    func setUp(title: String) {
        headerLabel.text = title
    }

}
