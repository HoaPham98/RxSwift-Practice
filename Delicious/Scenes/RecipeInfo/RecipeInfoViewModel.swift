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
    let recipe: RecipeType
}

extension RecipeInfoViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let favoriteTrigger: Driver<Void>
        let segmentTrigger: Driver<Int>
        let addToShoppingListTrigger: Driver<Void>
    }
    
    struct Output {
        let title: Driver<String>
        let recipe: Driver<RecipeType>
        let dataSource: Driver<[RecipeTableViewSection]>
        let shoppingButtonHidden: Driver<Bool>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let error: Driver<Error>
        let favoriteTap: Driver<Void>
    }
    
    func transform(_ input: RecipeInfoViewModel.Input) -> RecipeInfoViewModel.Output {
        let error = ErrorTracker()
        let title = input.loadTrigger.map { _ in
            return self.recipe.title
        }
        let recipe = input.loadTrigger.map { _ in
            return self.recipe
        }
        let recipeInfo = getItem(loadTrigger: input.loadTrigger, reloadTrigger: input.reloadTrigger) { _ in
            return self.useCase.getRecipe(id: self.recipe.id).trackError(error)
        }
        let favoriteTap = input.favoriteTrigger.do(onNext: { _ in
            
        })
        .mapToVoid()
        
        let dataSource = Driver.combineLatest(input.segmentTrigger, recipeInfo.item).flatMapLatest { (index, recipe) -> Driver<[RecipeTableViewSection]> in
            switch index {
            case 0:
                return Driver.just([RecipeTableViewSection.nutrientItem(item: recipe)])
            case 1:
                return Driver.just([RecipeTableViewSection.ingredientItem(item: recipe)])
            default:
                return Driver.just(recipe.analyzedInstructions.map { RecipeTableViewSection.stepItem(item: $0) })
            }
        }
        
        let isHidden = input.segmentTrigger.map { index in
            return index == 1
        }
        
        return Output(
            title: title,
            recipe: recipe,
            dataSource: dataSource,
            shoppingButtonHidden: isHidden,
            isLoading: recipeInfo.isLoading,
            isReloading: recipeInfo.isReloading,
            error: error.asDriver(),
            favoriteTap: favoriteTap.asDriver())
    }
}
