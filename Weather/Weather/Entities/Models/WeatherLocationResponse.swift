//
//  WeatherLocationResponse.swift
//  Weather
//
//  Created by Emre Tanrısever on 12.07.2024.
//

import Foundation

struct WeatherLocationResponse: Decodable {
    let sys: Sys
    let name: String
}

struct Sys: Decodable {
    let country: String
}
