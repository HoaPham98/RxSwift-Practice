//
//  SearchUseCase.swift
//  Delicious
//
//  Created by HoaPQ on 7/16/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

protocol SearchUseCaseType {
    func getRecentSearch() -> Observable<[String]>
    func search(query: String, tags: [SearchTag]) -> Observable<[RecipeType]>
}

struct SearchUseCase: SearchUseCaseType {
    func getRecentSearch() -> Observable<[String]> {
        return Observable.create { observable in
            let recent = Helpers.recentSearch
            observable.onNext(recent.storage)
            return Disposables.create()
        }
    }
    
    func search(query: String, tags: [SearchTag]) -> Observable<[RecipeType]> {
        let request = SearchRequest(query: query, tags: tags)
        return HomeRepositoy().search(input: request).map { $0 as [RecipeType] }
    }
}
