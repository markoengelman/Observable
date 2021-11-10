//
//  ObservableTests.swift
//  ObservableTests
//
//  Created by Marko Engelman on 10/11/2021.
//

import XCTest
@testable import Observable

class ObservableTests: XCTestCase {
    func test_init_hasNoSideEffectsOnInjectedValue() {
        let value = "value"
        let sut = Observable(value: value)
        XCTAssertEqual(sut.value, value)
        XCTAssertEqual(sut.wrappedValue, value)
        XCTAssertIdentical(sut.projectedValue, sut)
    }
    
    func test_observe_storesInjectedBlock() {
        let value = "value"
        let sut = Observable(value: value)
        let observationBlock: (String) -> Void = { _ in }
        sut.observe(observationBlock)
        XCTAssertEqual(sut.observers.count, 1)
    }
}
