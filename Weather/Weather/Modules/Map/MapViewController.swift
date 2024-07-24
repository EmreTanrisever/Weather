//
//  MapViewController.swift
//  Weather
//
//  Created by Emre Tanrısever on 17.07.2024.
//

import UIKit
import MapKit

protocol MapViewControllerProtocol: AnyObject, AlertShowable {
    func configure()
    func showSearchedLocationWeather()
}

final class MapViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var mapViewModel = MapViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension MapViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func handleTap(gestureRecognizer: UIGestureRecognizer) {
        
        let gestureLocation = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(gestureLocation, toCoordinateFrom: mapView)
        
        createAnnotation(coordinate: coordinate)
        
        let controller = WeatherViewController()
        var location: [String: Double] = [:]
        location["lat"] = coordinate.latitude
        location["lon"] = coordinate.longitude
        controller.configure(location: location, from: false)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func createAnnotation(coordinate: CLLocationCoordinate2D) {
        let allAnnotation = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotation)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: MapViewControllerProtocol {
    
    func configure() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubviews(mapView, searchBar)
        
        mapView.delegate = self
        
        let topGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        mapView.addGestureRecognizer(topGesture)
        
        setConstraints()
    }
    
    func showSearchedLocationWeather() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var location: [String: Double] = [:]
            location["lat"] = self.mapViewModel.coordinate?.lat
            location["lon"] = self.mapViewModel.coordinate?.lon
            let controller = WeatherViewController()
            controller.configure(location: location, from: false)
            let clLocation = CLLocationCoordinate2D(latitude: self.mapViewModel.coordinate!.lat, longitude: self.mapViewModel.coordinate!.lon)
            let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
            if let lat = location["lat"], let lon = location["lon"] {
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: span)
                mapView.setRegion(region, animated: true)
            }
            self.createAnnotation(coordinate: clLocation)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            mapViewModel.fetchCountryData(text: searchText)
        }
    }
}

