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
    func getWeatherForecast(
        apiKey: String,
        location: [String : Double],
        completion: @escaping (Result<WeatherResponse, NetworkErrors>) -> Void
    ) {
        invokedWeatherforecast = true
        invokedWeatherforecastCount += 1
        networkManager.execute(urlRequest: WeatherEndPoint.getLocation(lon: 0.0, lat: 0.0, apiKey: "")) { result in
            completion(result)
        }
    }
    
    func getWeatherIcon(
        icon: String,
        completion: @escaping (Result<Data, NetworkErrors>
        ) -> Void) {
        
    }
    
    func getLocation(
        apiKey: String,
        location: [String : Double],
        completion: @escaping (Result<WeatherLocationResponse, NetworkErrors>
        ) -> Void) {
        
    }
}
