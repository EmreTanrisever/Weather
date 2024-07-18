//
//  Decimal.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 16.07.2024.
//

import XCTest
@testable import Weather

final class Decimal: XCTestCase {

    func test_TimeStampExtension_Day() {
        let date = 1721113554.0
        XCTAssertEqual(date.getDay, "Tuesday")
    }
    
    func test_TimeStampExtension_Empty() {
        let date = 17211135542132.2
        XCTAssertEqual(date.getDay, "Empty")
    }
}
