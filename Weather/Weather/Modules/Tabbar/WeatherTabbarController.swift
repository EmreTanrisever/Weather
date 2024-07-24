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
    
    func configure(location: [String: Double]) {
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowColor = UIColor.systemGray.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        let home = WeatherViewController()
        home.configure(location: location, from: true)
        home.title = "home".localized
        home.tabBarItem.image = UIImage(named: "Home")
        home.tabBarItem.selectedImage = UIImage(named: "Homefill")
        
        let map = MapViewController()
        map.title = "map".localized
        map.tabBarItem.image = UIImage(named: "Pin")
        map.tabBarItem.selectedImage = UIImage(named: "Pinfill")
        
        setViewControllers([home, map], animated: false)
        self.modalPresentationStyle = .fullScreen
        
        tabBar.backgroundColor = UIColor(named: "BackgroundColor")
    }
}
