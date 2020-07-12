//
//  SegmentHeaderView.swift
//  Delicious
//
//  Created by HoaPQ on 7/11/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable
import Then

class SegmentHeaderView: UIView, NibLoadable {
    
    @IBOutlet weak var segmentControl: MBSegmentControl!
    
    func setUp(titles: [String]) {
        let settings = MBSegmentStripSettings().with {
            $0.stripRange = .segment
        }
        segmentControl.do {
            $0.selectedIndex = 0
            $0.backgroundColor = .white
            $0.style = .strip(settings)
            $0.segments = titles.map { TextSegment(text: $0) }
        }
    }
}

extension MBSegmentStripSettings: Then { }
