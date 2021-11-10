//
//  Observable.swift
//  Observable
//
//  Created by Marko Engelman on 10/11/2021.
//

import Foundation

@propertyWrapper
class Observable<T> {
    private (set) var observers: [(T) -> Void] = []
    
    var value: T
    
    init(value initialValue: T) {
        self.value = initialValue
        self.wrappedValue = initialValue
    }
    
    var wrappedValue: T {
        get { value }
        set {
            value = newValue
            observers.forEach { $0(newValue) }
        }
    }
    
    var projectedValue: Observable<T> { return self }
    
    func observe(_ closure: @escaping (T) -> Void) {
        observers.append(closure)
    }
}
