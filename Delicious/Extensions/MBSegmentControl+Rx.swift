//
//  MBSegmentControl+Rx.swift
//  Delicious
//
//  Created by HoaPQ on 7/12/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: MBSegmentControl {
    /// Reactive wrapper for `selectedSegmentIndex` property.
    public var selectedSegmentIndex: ControlProperty<Int> {
        return value
    }
    
    /// Reactive wrapper for `selectedSegmentIndex` property.
    public var value: ControlProperty<Int> {
        return controlProperty(editingEvents: .valueChanged,
                               getter: { $0.selectedIndex },
                               setter: { $0.selectedIndex = $1 })
    }
}
