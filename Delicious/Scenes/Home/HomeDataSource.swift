//
//  HomeDataSource.swift
//  Delicious
//
//  Created by HoaPQ on 7/12/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxDataSources

enum HomeTableViewItem {
    case featuredItem(items: [RecipeInformation])
    case lastestItem(item: RecipeInformation)
}

enum HomeTableViewSection {
    case featuredSection(items: [HomeTableViewItem])
    case lastestSection(items: [HomeTableViewItem])
}

extension HomeTableViewSection: SectionModelType {
    typealias Item = HomeTableViewItem

    var header: String {
        switch self {
        case .featuredSection:
            return "Featured"
        case .lastestSection:
            return "Lastest"
        }
    }
    
    var items: [HomeTableViewItem] {
        switch self {
        case .featuredSection(items: let items):
            return items
        case .lastestSection(items: let items):
            return items
        }
    }
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}
