//
//  WeatherServiceTests.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 21.07.2024.
//

import XCTest

import XCTest
@testable import Weather

final class TimeStampToHour_String: XCTestCase {

    func test_TimeStampExtension_Day() {
        let hour = 1721113554.0.getHour
        XCTAssertEqual(hour, "10:05")
    }
}
