//
//  WeatherServiceTests.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 11.08.2024.
//

import XCTest
@testable import Weather

final class WeatherServiceTests: XCTestCase {
    
    private var service: WeatherServiceProtocol?
    
    override func setUp() {
        super.setUp()
        service = WeatherService(networkManager: MockNetworkManager())
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
    }
    
    func test_WeatherService_GetWeatherForecast() {
        service?.getWeatherForecast(location: ["lat": 0.0, "lon": 0.0], completion: { result in
            switch result {
            case let .success(forecast):
                XCTAssertEqual(forecast.lat, 0)
                XCTAssertEqual(forecast.lon, 0)
                XCTAssertEqual(forecast.timezone, "Etc/GMT")
                XCTAssertEqual(forecast.daily.first?.dt, 1721131200)
                XCTAssertEqual(forecast.daily.first?.sunrise, 1721109739)
                XCTAssertEqual(forecast.daily.first?.sunset, 1721153367)
                XCTAssertEqual(forecast.daily.first?.moonrise, 1721137380)
                XCTAssertEqual(forecast.daily.first?.moonset, 1721092680)
                XCTAssertEqual(forecast.daily.first?.temp.day, 22.45)
                XCTAssertEqual(forecast.daily.first?.temp.min, 22.3)
                XCTAssertEqual(forecast.daily.first?.temp.max, 23)
                XCTAssertEqual(forecast.daily.first?.temp.night, 23)
                XCTAssertEqual(forecast.daily.first?.temp.eve, 22.99)
                XCTAssertEqual(forecast.daily.first?.temp.morn, 22.38)
                XCTAssertEqual(forecast.daily.first?.weather.first?.main, "Clouds")
                XCTAssertEqual(forecast.daily.first?.weather.first?.description, "overcast clouds")
                XCTAssertEqual(forecast.daily.first?.weather.first?.icon, "04d")
            case .failure(_):
                XCTFail()
            }
        })
    }
}
