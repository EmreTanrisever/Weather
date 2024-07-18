//
//  DeleteDecimal+Double.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 16.07.2024.
//

import XCTest
@testable import Weather

final class DeleteDecimal_Double: XCTestCase {

    func test_double_DeleteDecimal() {
        let data = 16.234
        XCTAssertEqual(data.deleteDecimal, "16")
    }

}
