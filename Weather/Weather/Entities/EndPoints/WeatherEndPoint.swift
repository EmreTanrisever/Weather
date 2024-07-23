//
//  WeatherEndPoint.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

enum WeatherEndPoint {
    case getWeatherForecast(lon: Double, lat: Double)
    case getLocation(lon: Double, lat: Double)
}

extension WeatherEndPoint: EndPointProtocol {
    var scheme: String {
        "https"
    }
    
    var host: String {
        switch self {
        case .getWeatherForecast(lon: _, lat: _):
            return "api.openweathermap.org"
        case .getLocation(lon: _, lat: _):
            return "api.openweathermap.org"
        }
    }
    
    var path: String {
        switch self {
        case .getWeatherForecast(lon: _, lat: _):
            return "/data/2.5/onecall"
        case .getLocation(lon: _, lat: _):
            return "/data/2.5/weather"
        }
    }
    
    var httpMethod: HttpMethods {
        switch self {
        case .getWeatherForecast(lon: _, lat: _):
            return .get
        case .getLocation(lon: _, lat: _):
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getWeatherForecast(lon: _, lat: _):
            return nil
        case .getLocation(lon: _, lat: _):
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getWeatherForecast(lon: let lon, lat: let lat):
            return [
                "lat": "\(lat)",
                "lon": "\(lon)",
                "lang": "en",
                "ced": "7",
                "appid": "8ddadecc7ae4f56fee73b2b405a63659",
                "units": "metric"
            ]
        case .getLocation(lon: let lon, lat: let lat):
            return [
                "lat": "\(lat)",
                "lon": "\(lon)",
                "lang": "en",
                "appid": "8ddadecc7ae4f56fee73b2b405a63659",
                "units": "metric"
            ]
        }
    }
    
    
}
