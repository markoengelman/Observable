//
//  Observable.swift
//  Observable
//
//  Created by Marko Engelman on 10/11/2021.
//

import Foundation

@propertyWrapper
class Observable<T> {
    var value: T
    
    init(value initialValue: T) {
        self.value = initialValue
        self.wrappedValue = initialValue
    }
    
    var wrappedValue: T {
        set { value = newValue }
        get { value }
    }
    
    var projectedValue: Observable<T> { return self }
}
