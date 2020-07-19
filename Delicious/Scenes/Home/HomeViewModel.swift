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
import RxDataSources

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectTrigger: Driver<RecipeType?>
        let searchTrigger: Driver<Void>
    }

    struct Output {
        let data: Driver<[HomeTableViewSection]>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let error: Driver<Error>
        let selected: Driver<Void>
        let search: Driver<Void>
    }

    func transform(_ input: HomeViewModel.Input) -> HomeViewModel.Output {
        let error = ErrorTracker()

        let getRecipes = getItem(
            loadTrigger: input.loadTrigger,
            reloadTrigger: input.reloadTrigger) { _ in
                return self.useCase.getRecipes().trackError(error)
        }
        
        let recipe = getRecipes.item.map { (recipes) -> [HomeTableViewSection] in
            let data = recipes.split()
            let featuredSection = HomeTableViewSection.featuredSection(items: [.featuredItem(items: data.left)])
            let lastestSection = HomeTableViewSection.lastestSection(items: data.right.map { HomeTableViewItem.lastestItem(item: $0) })
            return [featuredSection, lastestSection]
        }

        let selected = input.selectTrigger.do(onNext: { recipe in
            guard let recipe = recipe else { return }
            self.navigator.toInfomation(recipe: recipe)
        })
        .mapToVoid()
        
        let search = input.searchTrigger.do(onNext: { _ in
            self.navigator.toSearch()
            }).mapToVoid()

        return Output(
            data: recipe,
            isLoading: getRecipes.isLoading,
            isReloading: getRecipes.isReloading,
            error: error.asDriver(),
            selected: selected,
            search: search)
    }
}
