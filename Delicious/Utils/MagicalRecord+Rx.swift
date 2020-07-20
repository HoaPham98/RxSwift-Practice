//
//  MagicalRecord+Rx.swift
//  Delicious
//
//  Created by HoaPQ on 7/14/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import MagicalRecord
import RxSwift

extension Reactive where Base: MagicalRecord {
    static func save(block: @escaping (NSManagedObjectContext?) -> Void) -> Observable<Bool> {
        print("Outside block....")
        return Observable.create { observer in
            print("Inside block...")
            MagicalRecord.save(block, completion: { (changed, error) in
                if let error = error {
                    observer.onError(error)
                } else if changed {
                    observer.onNext(changed)
                } else {
                    observer.onError(CoreDataError.alreadyExist)
                }
            })
            return Disposables.create()
        }.debug()
    }
    
    static func save(block: @escaping (NSManagedObjectContext?) -> Void) -> Observable<Void> {
        let observable: Observable<Bool> = MagicalRecord.rx.save(block: block)
        return observable.map { _ in () }
    }
}
