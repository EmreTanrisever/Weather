//
//  WeatherTabbarController.swift
//  Weather
//
//  Created by Emre Tanrısever on 17.07.2024.
//

import UIKit

class WeatherTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(apiKey: String, location: [String: Double]) {
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowColor = UIColor.systemGray.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        let home = WeatherViewController()
        home.configure(apiKey: apiKey, location: location)
        home.title = "home".localized
        home.tabBarItem.image = UIImage(systemName: "house")
        home.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let map = MapViewController()
        map.title = "map".localized
        map.tabBarItem.image = UIImage(systemName: "map")
        map.tabBarItem.selectedImage = UIImage(systemName: "map.fill")
        
        setViewControllers([home, map], animated: false)
        self.modalPresentationStyle = .fullScreen
        tabBar.backgroundColor = UIColor(named: "BackgroundColor")
    }
}
