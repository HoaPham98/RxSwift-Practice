//
//  SearchViewModel.swift
//  Delicious
//
//  Created by HoaPQ on 7/16/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCase
}

extension SearchViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        let data: Driver<[SearchCollectionViewSection]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let data = [
            SearchCollectionViewSection.tagSection(items: Search.cuisines.map { SearchCollectionViewItem.tag(item: Search.cuisine($0) )}),
            SearchCollectionViewSection.tagSection(items: Search.mealTypes.map { SearchCollectionViewItem.tag(item: Search.type($0) )}),
            SearchCollectionViewSection.tagSection(items: Search.diets.map { SearchCollectionViewItem.tag(item: Search.diet($0) )})
        ]
        
        return Output(data: Driver.just(data))
    }
}
