//
//  ViewController.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import UIKit
import CoreLocation
import Lottie

protocol HomeViewProtocol: AnyObject, AlertShowable {
    
    func configure()
    func prepareLocation()
    func configureAnimation(animationName: String)
    func playAnimation()
    func stopAnimation()
}

final class HomeViewController: UIViewController {
    
    private var animationView: LottieAnimationView!
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(view: self)
    private var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.viewDidLoad()
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func configure() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func prepareLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    func configureAnimation(animationName: String) {
        animationView = .init(name: animationName)
        animationView.frame = view.frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
    }
    
    func playAnimation() {
        animationView.play()
    }
    
    func stopAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            self.animationView.stop()
            let controller = WeatherTabbarController()
            controller.configure(location: viewModel.returnLocation())
            viewModel.navigate ? self.view.window?.rootViewController = UINavigationController(rootViewController: controller) : viewModel.alert()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        viewModel.addLocation(lat: first.coordinate.latitude, lon: first.coordinate.longitude)
    }
}
