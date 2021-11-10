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
    }
}
