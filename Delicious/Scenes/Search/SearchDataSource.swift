//
//  SearchDataSource.swift
//  Delicious
//
//  Created by HoaPQ on 7/18/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxDataSources

enum SearchCollectionViewItem {
    case tag(item: Search)
    case result(item: RecipeType)
}

enum SearchCollectionViewSection {
    case tagSection(items: [SearchCollectionViewItem])
    case resultSection(items: [SearchCollectionViewItem])
}

extension SearchCollectionViewSection: SectionModelType {
    typealias Item = SearchCollectionViewItem
    
    var header: String {
        return ""
    }
    var items: [SearchCollectionViewItem] {
        switch self {
        case .resultSection(let recipes):
            return recipes
        case .tagSection(let tags):
            return tags
        }
    }
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
    
    init(original: Self, items: [Self.Item], header: String) {
        self = original
    }
}
