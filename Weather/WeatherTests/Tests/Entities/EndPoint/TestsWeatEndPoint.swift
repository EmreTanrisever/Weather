//
//  TestsWeatEndPoint.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 16.07.2024.
//

import XCTest
@testable import Weather

final class TestsWeatEndPoint: XCTestCase {
    
    private var endPoint: EndPointProtocol!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        self.endPoint = nil
    }
    
    func test_getWeatherForecast_RequiredVariables() {
        self.endPoint = WeatherEndPoint.getWeatherForecast(lon: 0.0, lat: 0.0)
        XCTAssertEqual(endPoint.scheme, "https")
        XCTAssertEqual(endPoint.host, "api.openweathermap.org")
        XCTAssertEqual(endPoint.path, "/data/2.5/onecall")
        XCTAssertEqual(endPoint.httpMethod, .get)
        XCTAssertNil(endPoint.header)
        
        let lat = endPoint.parameters?["lat"]
        let lon = endPoint.parameters?["lon"]
        let lang = endPoint.parameters?["lang"]
        let ced = endPoint.parameters?["ced"]
        let appid = endPoint.parameters?["appid"]
        let units = endPoint.parameters?["units"]
        
        XCTAssertEqual(lat as! String, "0.0")
        XCTAssertEqual(lon as! String, "0.0")
        XCTAssertEqual(lang as! String, "en")
        XCTAssertEqual(ced as! String, "7")
        XCTAssertEqual(appid as! String, "8ddadecc7ae4f56fee73b2b405a63659")
        XCTAssertEqual(units as! String, "metric")
    }
    
    func test_getLocation_RequiredVariables() {
        self.endPoint = WeatherEndPoint.getLocation(lon: 0.0, lat: 0.0)
        XCTAssertEqual(endPoint.scheme, "https")
        XCTAssertEqual(endPoint.host, "api.openweathermap.org")
        XCTAssertEqual(endPoint.path, "/data/2.5/weather")
        XCTAssertEqual(endPoint.httpMethod, .get)
        XCTAssertNil(endPoint.header)
        
        let lat = endPoint.parameters?["lat"]
        let lon = endPoint.parameters?["lon"]
        let lang = endPoint.parameters?["lang"]
        let appid = endPoint.parameters?["appid"]
        let units = endPoint.parameters?["units"]
        
        XCTAssertEqual(lat as! String, "0.0")
        XCTAssertEqual(lon as! String, "0.0")
        XCTAssertEqual(lang as! String, "en")
        XCTAssertEqual(appid as! String, "8ddadecc7ae4f56fee73b2b405a63659")
        XCTAssertEqual(units as! String, "metric")
    }
}
