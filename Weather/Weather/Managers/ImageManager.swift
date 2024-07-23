//
//  ImageManager.swift
//  Weather
//
//  Created by Emre Tanrısever on 23.07.2024.
//

import Foundation

final class ImageManager {
    
    private init() {  }
    
    static let shared = ImageManager()
    
    func returnWeatherImage(imageName: String) -> String {
        switch imageName {
        case "01d":
            return "SunIconLight"
        case "01n":
            return "SunIconDark"
        case "02d":
            return "CloudIconLight"
        case "02n":
            return "CloudIconDark"
        case "03d":
            return "CloudIconLight"
        case "03n":
            return "CloudIconDark"
        case "04d":
            return "CloudIconLight"
        case "04n":
            return "CloudIconDark"
        case "09d":
            return "RainIconLight"
        case "09n":
            return "RainIconDark"
        case "10d":
            return "RainIconLight"
        case "10n":
            return "RainIconDark"
        case "11d":
            return "ThunderStormIconLight"
        case "11n":
            return "ThunderStormIconDark"
        case "13d":
            return "SnowIconLight"
        case "13n":
            return "SnowIconDark"
        case "50d":
            return ""
        case "50n":
            return ""
        default:
            return ""
        }
    }
}
