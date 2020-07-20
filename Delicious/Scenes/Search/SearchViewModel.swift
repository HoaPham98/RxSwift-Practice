//
//  SearchViewModel.swift
//  Delicious
//
//  Created by HoaPQ on 7/16/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

struct SearchModel {
    let text: String
    let tags: [SearchTag]
}

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCase
}

extension SearchViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let searchTrigger: Driver<SearchModel>
        let autoCompletion: Driver<String>
        let selectTrigger: Driver<RecipeType>
    }
    
    struct Output {
        let data: Driver<[SearchCollectionViewSection]>
//        let selected: Driver<Void>
//        let autoCompletion: Driver<Void>
//        let search: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let searchTags = [
            SearchCollectionViewSection.tagSection(items: SearchTag.cuisines.map { SearchCollectionViewItem.tag(item: SearchTag.cuisine($0) )}),
            SearchCollectionViewSection.tagSection(items: SearchTag.mealTypes.map { SearchCollectionViewItem.tag(item: SearchTag.type($0) )}),
            SearchCollectionViewSection.tagSection(items: SearchTag.diets.map { SearchCollectionViewItem.tag(item: SearchTag.diet($0) )})
        ]
        
        return Output(data: Driver.just(searchTags))
    }
}
