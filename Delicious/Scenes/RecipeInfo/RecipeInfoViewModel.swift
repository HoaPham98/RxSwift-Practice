//
//  RecipeInfoViewModel.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct RecipeInfoViewModel {
    let navigator: RecipeInfoNavigatorType
    let useCase: RecipeInfoUseCaseType
}

extension RecipeInfoViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let addToShoppingListTrigger: Driver<[Ingredients]>
    }
    
    struct Output {
        let data: Driver<RecipeInformation>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let error: Driver<Error>
    }
    
    func transform(_ input: RecipeInfoViewModel.Input) -> RecipeInfoViewModel.Output {
        let error = ErrorTracker()
        let recipe = getItem(loadTrigger: input.loadTrigger, reloadTrigger: input.reloadTrigger) { _ in
            return self.useCase.getRecipe(id: 0).trackError(error)
        }
        
        return Output(data: recipe.item,
                      isLoading: recipe.isLoading,
                      isReloading: recipe.isReloading,
                      error: error.asDriver())
    }
}
