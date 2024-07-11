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
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moon_phase: Double
    let temp: Temp
}

struct Temp: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}
