//
//  WeatherServiceTests.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 21.07.2024.
//

import XCTest
@testable import Weather

final class WeatherServiceTests: XCTestCase {
    
    private var mockService: MockWeatherService!
    
    override func setUp() {
        super.setUp()
        mockService = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        mockService = nil
    }
    
    func test_weatherService_GetWeatherForecast() {
        XCTAssertFalse(mockService.invokedWeatherforecast)
        XCTAssertEqual(mockService.invokedWeatherforecastCount, 0)
        
        mockService.getWeatherForecast(apiKey: "", location: ["":0.0]) { result in
            switch result {
            case let .success(weather):
                XCTAssertEqual(weather.lat, 0.0)
                XCTAssertEqual(weather.lon, 0.0)
                XCTAssertEqual(weather.timezone, "Etc/GMT")
                XCTAssertEqual(weather.daily.first!.dt, 1721131200.0)
                XCTAssertEqual(weather.daily.first!.sunrise, 1721109739)
                XCTAssertEqual(weather.daily.first!.sunset, 1721153367)
                XCTAssertEqual(weather.daily.first!.moonrise, 1721137380)
                XCTAssertEqual(weather.daily.first!.moonset, 1721092680)
            case .failure(_):
                XCTFail()
            }
        }
        
        XCTAssertTrue(mockService.invokedWeatherforecast)
        XCTAssertEqual(mockService.invokedWeatherforecastCount, 1)
    }
}
