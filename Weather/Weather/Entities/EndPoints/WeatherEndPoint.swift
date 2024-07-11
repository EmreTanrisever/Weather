//
//  WeatherEndPoint.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

enum WeatherEndPoint {
    case getWeatherForecast(lon: Double, lat: Double, apiKey: String)
    case getWeatherIcon(icon: String)
}

extension WeatherEndPoint: EndPointProtocol {
    var scheme: String {
        "https"
    }
    
    var host: String {
        switch self {
        case .getWeatherForecast(lon: _, lat: _, apiKey: _):
            return "api.openweathermap.org"
        case .getWeatherIcon(icon: _):
            return "openweathermap.org"
        }
    }
    
    var path: String {
        switch self {
        case .getWeatherForecast(lon: _, lat: _, apiKey: _):
            return "/data/2.5/onecall"
        case .getWeatherIcon(icon: let icon):
            return "/img/wn/\(icon)@2x.png"
        }
    }
    
    var httpMethod: HttpMethods {
        switch self {
        case .getWeatherForecast(lon: _, lat: _, apiKey: _):
            return .get
        case .getWeatherIcon(icon: _):
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getWeatherForecast(lon: _, lat: _, apiKey: _):
            return nil
        case .getWeatherIcon(icon: _):
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getWeatherForecast(lon: let lon, lat: let lat, apiKey: let apiKey):
            return [
                "lat": "\(lat)",
                "lon": "\(lon)",
                "lang": "en",
                "ced": "7",
                "appid": apiKey,
                "units": "metric"
            ]
        case .getWeatherIcon(icon: _):
            return nil
        }
    }
    
    
}
