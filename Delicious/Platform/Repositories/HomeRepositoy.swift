//
//  HomeRepositoy.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import RxSwift

protocol HomeRespositoryType {
    func getHomeData(input: HomeRequest) -> Observable<[RecipeInformation]>
    func getRecipeInfomation(input: RecipeInfoRequest) -> Observable<RecipeInformation>
    func search(input: SearchRequest) -> Observable<[RecipeInformation]>
    func autoCompletion(input: AutoCompletionRequest) -> Observable<[AutoCompletion]>
}

struct HomeRepositoy: HomeRespositoryType {
    private let api = APIService.share
    
    func getHomeData(input: HomeRequest) -> Observable<[RecipeInformation]> {
        return Observable<[RecipeInformation]>.create { observer in
            if let path = Bundle.main.path(forResource: "response-2", ofType: "json") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    if let response = HomeResponse(JSONString: data) {
                        observer.onNext(response.recipes)
                    } else {
                        observer.onError(BaseError.networkError)
                    }
                } catch let error {
                    observer.onError(error)
                }
            } else {
                observer.onError(BaseError.networkError)
            }
            return Disposables.create()
        }
//        return api.request(input: input).map { (response: HomeResponse) in
//            return response.recipes
//        }
    }
    
    func getRecipeInfomation(input: RecipeInfoRequest) -> Observable<RecipeInformation> {
        return Observable<RecipeInformation>.create { observer in
            if let path = Bundle.main.path(forResource: "response", ofType: "json") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    if let response = RecipeInformation(JSONString: data) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                            observer.onNext(response)
                            })
                    } else {
                        observer.onError(BaseError.networkError)
                    }
                } catch let error {
                    observer.onError(error)
                }
            } else {
                observer.onError(BaseError.networkError)
            }
            return Disposables.create()
        }
//        return api.request(input: input).map { (response: RecipeInformation) in
//            return response
//        }
    }
    
    func search(input: SearchRequest) -> Observable<[RecipeInformation]> {
        return Observable<[RecipeInformation]>.create { observer in
            if let path = Bundle.main.path(forResource: "response-2", ofType: "json") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    if let response = HomeResponse(JSONString: data) {
                        observer.onNext(response.recipes)
                    } else {
                        observer.onError(BaseError.networkError)
                    }
                } catch let error {
                    observer.onError(error)
                }
            } else {
                observer.onError(BaseError.networkError)
            }
            return Disposables.create()
        }
    }
    
    func autoCompletion(input: AutoCompletionRequest) -> Observable<[AutoCompletion]> {
        return Observable<[AutoCompletion]>.create { observable in
            let arr = ["Chicken", "Meat", "Apple", "Pineapple"]
            observable.onNext(arr.map { AutoCompletion(title: $0) })
            return Disposables.create()
        }
    }
}
