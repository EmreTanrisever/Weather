//
//  MockWeatherService.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 16.07.2024.
//

import Foundation
@testable import Weather

final class MockWeatherService: WeatherServiceProtocol {
    let networkManager = MockNetworkManager()

    var invokedWeatherforecast = false
    var invokedWeatherforecastCount = 0
    func getWeatherForecast(location: [String : Double], completion: @escaping (Result<WeatherResponse, NetworkErrors>) -> Void) {
        invokedWeatherforecast = true
        invokedWeatherforecastCount = 1
        
        networkManager.execute(urlRequest: WeatherEndPoint.getLocation(lon: 0.0, lat: 0.0)) { result in
            completion(result)
        }
    }
    
    var invokedGetLocation = false
    var invokedGetLocationCount = 0
    func getLocation(location: [String : Double], completion: @escaping (Result<WeatherLocationResponse, NetworkErrors>) -> Void) {
        invokedGetLocation = true
        invokedGetLocationCount = 1
    }
    
    var invokedGetCountyData = false
    var invokedGetCountyDataCount = 0
    func getCountryData(text: String, completion: @escaping (Result<WeatherLocationResponse, NetworkErrors>) -> Void) {
        invokedGetCountyData = true
        invokedGetCountyDataCount = 1
    }
}
