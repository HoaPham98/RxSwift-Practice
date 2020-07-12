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
}

struct HomeRepositoy: HomeRespositoryType {
    private let api = APIService.share
    
    func getHomeData(input: HomeRequest) -> Observable<[RecipeInformation]> {
        return Observable<[RecipeInformation]>.create( { observer in
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
        })
        
//        return api.request(input: input).map { (response: HomeResponse) in
//            return response.recipes
//        }
    }
    
    func getRecipeInfomation(input: RecipeInfoRequest) -> Observable<RecipeInformation> {
        return Observable<RecipeInformation>.create( { observer in
            if let path = Bundle.main.path(forResource: "response-2", ofType: "json") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    if let response = HomeResponse(JSONString: data) {
                        observer.onNext(response.recipes[0])
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
        })
    }
}
