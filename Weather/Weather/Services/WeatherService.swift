//
//  WeatherService.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol WeatherServiceProtocol {
    
    func getWeatherForecast(completion: @escaping(Result<WeatherResponse, NetworkErrors>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
    
    func getWeatherForecast(completion: @escaping (Result<WeatherResponse, NetworkErrors>) -> Void) {
        NetworkManager.shared.execute(urlRequest: WeatherEndPoint.getWeatherForecast(lon: 44.34, lat: 10.99)) { result in
            completion(result)
        }
    }
}
