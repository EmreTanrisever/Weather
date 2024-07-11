//
//  WeatherService.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol WeatherServiceProtocol {
    
    func getWeatherForecast(apiKey: String, completion: @escaping(Result<WeatherResponse, NetworkErrors>) -> Void)
    func getWeatherIcon(icon: String, completion: @escaping(Result<Data, NetworkErrors>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
    
    func getWeatherForecast(apiKey: String, completion: @escaping (Result<WeatherResponse, NetworkErrors>) -> Void) {
        NetworkManager.shared.execute(urlRequest: WeatherEndPoint.getWeatherForecast(lon: 44.34, lat: 10.99, apiKey: apiKey)) { result in
            completion(result)
        }
    }
    
    func getWeatherIcon(icon: String, completion: @escaping(Result<Data, NetworkErrors>) -> Void) {
        NetworkManager.shared.execute(urlRequest: WeatherEndPoint.getWeatherIcon(icon: icon)) { result in
            completion(result)
        }
    }
}
