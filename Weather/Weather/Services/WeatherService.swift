//
//  WeatherService.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol WeatherServiceProtocol {
    
    func getWeatherForecast(location: [String: Double], completion: @escaping (Result<WeatherResponse, NetworkErrors>) -> Void)
    func getLocation(location: [String: Double], completion: @escaping (Result<WeatherLocationResponse, NetworkErrors>) -> Void)
    func getCountryData(text: String, completion: @escaping (Result<WeatherLocationResponse, NetworkErrors>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
    
    func getWeatherForecast(location: [String: Double], completion: @escaping (Result<WeatherResponse, NetworkErrors>) -> Void) {
        guard let lon = location["lon"], let lat = location["lat"] else { return }
        NetworkManager.shared.execute(urlRequest: WeatherEndPoint.getWeatherForecast(lon: lon, lat: lat)) { result in
            completion(result)
        }
    }
    
    func getLocation(location: [String : Double], completion: @escaping (Result<WeatherLocationResponse, NetworkErrors>) -> Void) {
        guard let lon = location["lon"], let lat = location["lat"] else { return }
        NetworkManager.shared.execute(urlRequest: WeatherEndPoint.getLocation(lon: lon, lat: lat)) { result in
            completion(result)
        }
    }
    
    func getCountryData(text: String, completion: @escaping (Result<WeatherLocationResponse, NetworkErrors>) -> Void) {
        NetworkManager.shared.execute(urlRequest: WeatherEndPoint.getSpesificLocation(cityName: text.lowercased())) { result in
            completion(result)
        }
    }
}
