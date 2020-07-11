//
//  CustomNavigationController.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        changeTitleColor()
        changeBackIcon()
        changeNavigationColor()
    }
    
    func changeTitleColor() {
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func changeBackIcon() {
        let barAppearance =
            UINavigationBar.appearance(whenContainedInInstancesOf: [CustomNavigationController.self])
        barAppearance.backIndicatorImage = Icon.icBack
        barAppearance.backIndicatorTransitionMaskImage = Icon.icBack
        barAppearance.tintColor = .white
    }

    func changeNavigationColor() {
        navigationBar.barTintColor = .systemOrange
    }
}
