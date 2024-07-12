//
//  WeatherService.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol WeatherServiceProtocol {
    
    func getWeatherForecast(apiKey: String, location: [String: Double], completion: @escaping (Result<WeatherResponse, NetworkErrors>) -> Void)
    func getWeatherIcon(icon: String, completion: @escaping(Result<Data, NetworkErrors>) -> Void)
    func getLocation(apiKey: String, location: [String: Double], completion: @escaping (Result<WeatherLocationResponse, NetworkErrors>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
    
    func getWeatherForecast(apiKey: String, location: [String: Double], completion: @escaping (Result<WeatherResponse, NetworkErrors>) -> Void) {
        guard let lon = location["lon"], let lat = location["lat"] else { return }
        NetworkManager.shared.execute(urlRequest: WeatherEndPoint.getWeatherForecast(lon: lon, lat: lat, apiKey: apiKey)) { result in
            completion(result)
        }
    }
    
    func getWeatherIcon(icon: String, completion: @escaping(Result<Data, NetworkErrors>) -> Void) {
        NetworkManager.shared.fetchImage(urlRequest: WeatherEndPoint.getWeatherIcon(icon: icon)) { result in
            completion(result)
        }
    }
    
    func getLocation(apiKey: String, location: [String : Double], completion: @escaping (Result<WeatherLocationResponse, NetworkErrors>) -> Void) {
        guard let lon = location["lon"], let lat = location["lat"] else { return }
        NetworkManager.shared.execute(urlRequest: WeatherEndPoint.getLocation(lon: lon, lat: lat, apiKey: apiKey)) { result in
            completion(result)
        }
    }
}
