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
        let favoriteTrigger: Driver<Bool>
        let segmentTrigger: Driver<Int>
        let addToShoppingListTrigger: Driver<Void>
    }
    
    struct Output {
        let title: Driver<String>
        let recipe: Driver<RecipeType>
        let isFavorited: Driver<Bool>
        let dataSource: Driver<[RecipeTableViewSection]>
        let shoppingButtonHidden: Driver<Bool>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let error: Driver<Error>
    }
    
    func transform(_ input: RecipeInfoViewModel.Input) -> RecipeInfoViewModel.Output {
        let error = ErrorTracker()
        let title = input.loadTrigger.map { _ in
            return self.recipe.title
        }
        let recipe = input.loadTrigger.map { _ in
            return self.recipe
        }
        let recipeInfo = getItem(
            loadTrigger: input.loadTrigger,
            reloadTrigger: input.reloadTrigger) { _ in
            return self.useCase.getRecipe(id: self.recipe.id).trackError(error)
        }
        let isFavorited = input.loadTrigger.flatMapLatest { _ in
            self.useCase
                .checkFavorite(recipe: self.recipe)
                .asDriverOnErrorJustComplete()
        }
        let favoriteTap = Driver
            .combineLatest(recipe, input.favoriteTrigger)
            .flatMapLatest { (recipe, status) -> Driver<Bool> in
                self.useCase
                    .updateFavorite(recipe: recipe, status: status)
                    .map { return status }
                    .asDriverOnErrorJustComplete()
        }
        
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
            isFavorited: Driver.merge(isFavorited, favoriteTap),
            dataSource: dataSource,
            shoppingButtonHidden: isHidden,
            isLoading: recipeInfo.isLoading,
            isReloading: recipeInfo.isReloading,
            error: error.asDriver())
    }
}
