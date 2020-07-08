//
//  HomeNavigator.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit

protocol HomeNavigatorType {
    func toInfomation(id: Int)
    func toSearch()
}

struct HomeNavigator: HomeNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toInfomation(id: Int) {
        // TODO: Go to Infomation Screen
    }
    
    func toSearch() {
        // TODO: Go to Search Screen
    }
}
