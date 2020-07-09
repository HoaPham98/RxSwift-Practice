//
//  HomeUseCase.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift

protocol HomeUseCaseType {
    func getRecipes() -> Observable<[RecipeInformation]>
}

struct HomeUseCase: HomeUseCaseType {
    
    func getRecipes() -> Observable<[RecipeInformation]> {
        let repository = HomeRepositoy()
        let request = HomeRequest()
        return repository.getHomeData(input: request)
    }
}
