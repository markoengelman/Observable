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
        let (sut, value) = makeSUT()
        XCTAssertEqual(sut.value, value)
        XCTAssertEqual(sut.wrappedValue, value)
        XCTAssertIdentical(sut.projectedValue, sut)
    }
    
    func test_observe_storesInjectedBlock() {
        let (sut, _) = makeSUT()
        let observationBlock: (String) -> Void = { _ in }
        sut.observe(observationBlock)
        XCTAssertEqual(sut.observers.count, 1)
    }
    
    func test_observationBlock_triggeredOnChange() {
        let (sut, _) = makeSUT()
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
    
    func test_observationBlock_doesntGetTriggered_onTokenCancelation() {
        let (sut, _) = makeSUT()
        let exp = expectation(description: "Waiting for change")
        exp.isInverted = true
        var blockTriggered = false
        
        let observationBlock: (String) -> Void = { _ in
            blockTriggered = true
            exp.fulfill()
        }
        
        let token = sut.observe(observationBlock)
        token.cancel()
        sut.wrappedValue = "a new value"
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertFalse(blockTriggered)
    }
}

// MARK: - Private
private extension ObservableTests {
    func makeSUT() -> (Observable<String>, String) {
        let value = "value"
        let sut = Observable(value: value)
        return (sut, value)
    }
}
