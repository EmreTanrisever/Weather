//
//  MapViewController.swift
//  Weather
//
//  Created by Emre Tanrısever on 17.07.2024.
//

import UIKit
import MapKit

protocol MapViewControllerProtocol {
    func configure()
}

final class MapViewController: UIViewController {
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var mapViewModel = MapViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewModel.viewDidLoad()
    }
    
}

extension MapViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func handleTap(gestureRecognizer: UIGestureRecognizer) {
        let locaiton = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(locaiton, toCoordinateFrom: mapView)
        let allAnnotation = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotation)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        mapView.addAnnotation(annotation)
        let controller = WeatherViewController()
        var location: [String: Double] = [:]
        location["lat"] = coordinate.latitude
        location["lon"] = coordinate.longitude
        controller.configure(apiKey: "8ddadecc7ae4f56fee73b2b405a63659", location: location)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MapViewController: MapViewControllerProtocol {
    
    func configure() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        let topGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        mapView.addGestureRecognizer(topGesture)
        
        setConstraints()
    }
}

extension MapViewController: MKMapViewDelegate {
    
}

