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
    
    func test_observationBlock_triggeredOnChange() {
        let value = "value"
        let sut = Observable(value: value)
        let exp = expectation(description: "Waiting for change")
        var blockTriggered = false
        let observationBlock: (String) -> Void = { _ in
            blockTriggered = true
            exp.fulfill()
        }
        
        sut.observe(observationBlock)
        sut.wrappedValue = "a new value"
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertTrue(blockTriggered)
    }
}
