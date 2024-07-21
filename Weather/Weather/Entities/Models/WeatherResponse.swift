//
//  WeatherResponse.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let daily: [Daily]
    let hourly: [Hourly]
}

struct Current: Decodable {
    let temp: Double
    //let feels_like: Double
    //let pressure: Int
    //let clouds: Int
    //let wind_speed: Int
    //let wind_deg: Int
}

struct Daily: Decodable {
    let dt: Double
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moon_phase: Double
    let temp: Temp
    let weather: [Weather]
}

struct Hourly: Decodable {
    let dt: Double
    let temp: Double
    let weather: [Weather]
}

struct Temp: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}
