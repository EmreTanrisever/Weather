//
//  SplashViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation
import Network

protocol SplashViewModelProtocol {
    var navigate: Bool { get set }
    func viewDidLoad()
    func addLocation(lat: Double, lon: Double)
    func returnLocation() -> [String: Double]?
    func alert()
}

final class SplashViewModel {
    private weak var view: SplashViewProtocol?
    private var location: [String: Double] = [:]
    
    var navigate = false
    
    init(view: SplashViewProtocol? = nil) {
        self.view = view
    }
}

extension SplashViewModel: SplashViewModelProtocol {
    
    func viewDidLoad() {
        checkInternetConnection()
        view?.configure()
        view?.prepareLocation()
        view?.configureAnimation(animationName: "Animation-1721633222111")
        view?.playAnimation()
        view?.stopAnimation()
    }
    
    func addLocation(lat: Double, lon: Double) {
        location["lat"] = lat
        location["lon"] = lon
    }
    
    func returnLocation() -> [String : Double]? {
        if location.isEmpty {
            return nil
        }
        return location
    }
    
    func alert() {
        view?.showAlert(type: .noInternetConnection)
    }
}

extension SplashViewModel {
    
    private func checkInternetConnection() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.navigate = true
                return
            }
            self.navigate = false            
        }
        monitor.start(queue: DispatchQueue(label: "NetworkMonitor"))
    }
}
