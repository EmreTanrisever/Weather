//
//  WeatherEndPoint.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

enum WeatherEndPoint {
    case getWeatherForecast(lon: Double, lat: Double)
}

extension WeatherEndPoint: EndPointProtocol {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.openweathermap.org"
    }
    
    var path: String {
        "/data/2.5/onecall"
    }
    
    var httpMethod: HttpMethods {
        switch self {
        case .getWeatherForecast(lon: _, lat: _):
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getWeatherForecast(lon: _, lat: _):
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
        }
    }
    
    
}
