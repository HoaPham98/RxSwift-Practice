//
//  HomeViewModel.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct HomeDataType {
    let featured: [RecipeInformation]
    let lastest: [RecipeInformation]
}

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectTrigger: Driver<RecipeInformation>
    }

    struct Output {
        let data: Driver<HomeDataType>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let error: Driver<Error>
        let selected: Driver<Void>
    }

    func transform(_ input: HomeViewModel.Input) -> HomeViewModel.Output {
        let error = ErrorTracker()

        let getRecipes = getItem(
            loadTrigger: input.loadTrigger,
            reloadTrigger: input.reloadTrigger) { _ in
                return self.useCase.getRecipes().trackError(error)
        }
        
        let recipe = getRecipes.item.map { (recipes) -> HomeDataType in
            let data = recipes.split()
            return HomeDataType(featured: data.left, lastest: data.right)
        }

        let selected = input.selectTrigger.do(onNext: { recipe in
            self.navigator.toInfomation(id: recipe.id)
        })
        .mapToVoid()

        return Output(
            data: recipe,
            isLoading: getRecipes.isLoading,
            isReloading: getRecipes.isReloading,
            error: error.asDriver(),
            selected: selected)
    }
}
