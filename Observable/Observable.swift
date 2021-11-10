//
//  Observable.swift
//  Observable
//
//  Created by Marko Engelman on 10/11/2021.
//

import Foundation

class Observable<T> {
    var value: T
    
    init(value initialValue: T) {
        self.value = initialValue
    }
}
