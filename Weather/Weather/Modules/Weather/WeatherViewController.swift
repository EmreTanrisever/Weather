//
//  WeatherViewController.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import UIKit
import CoreLocation

protocol WeatherViewControllerProtocol: AnyObject, AlertShowable {
    func configure(location: [String: Double]?, from isDetail: Bool)
    func startSpinnerAnimation()
    func stopSpinnerAnimation()
    func reloadTableView()
    func stopRefreshing()
    func showLocationPermissionView()
    func showWeatherView()
}

final class WeatherViewController: UIViewController {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodayForecastTableViewCell.self, forCellReuseIdentifier: "TodayForecastTableViewCell")
        tableView.register(HourForecastTableViewCell.self, forCellReuseIdentifier: "HourForecastTableViewCell")
        tableView.register(TodayForecastTableViewCell.self, forCellReuseIdentifier: "DailyForecastTableViewCell")
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "location.slash.fill")
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "locationServicesDisabled".localized
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "pleaseEnableLocationServicesToUseTheWeatherApp".localized
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("goToSettings".localized, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        return button
    }()
    
    lazy var viewModel: WeatherViewModelProtocol = WeatherViewModel(view: self)
    private var isDetail: Bool = false
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationPermission()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isDetail ? hideNavigationBar() : showNavigationBar()
        checkLocationPermission()
    }
}

// MARK: - WeatherViewController extension
extension WeatherViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func hideNavigationBar() {
        DispatchQueue.main.async {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    private func showNavigationBar() {
        DispatchQueue.main.async {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            settingsButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30),
            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 200),
            settingsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func openSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }
    }
    
    @objc
    private func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.viewModel.fetchWeatherData(location: self.viewModel.spesificLocation)
            self.viewModel.returnLocation(location: self.viewModel.spesificLocation)
        }
    }
}

// MARK: - WeatherViewControllerProtocol
extension WeatherViewController: WeatherViewControllerProtocol {
    
    func configure(location: [String: Double]?, from isDetail: Bool) {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        viewModel.spesificLocation = location ?? [:]
        if !isDetail {
            viewModel.fetchWeatherData(location: viewModel.spesificLocation)
            viewModel.returnLocation(location: viewModel.spesificLocation)
        }
        self.isDetail = isDetail
        
        weatherTableView.refreshControl = refreshControl
        
        view.addSubviews(weatherTableView, spinner)
        setConstraints()
        
        setupUI()
    }
    
    func startSpinnerAnimation() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    func stopSpinnerAnimation() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
    
    func stopRefreshing() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
        
    func showWeatherView() {
        weatherTableView.isHidden = false
        spinner.isHidden = false
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 500
        case 1:
            return 112
        case 2:
            return 72
        default:
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return viewModel.daily.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = TodayForecastTableViewCell()
            if let image = viewModel.returnTodayImage(), let today = viewModel.today {
                cell.configure(image: image, location: viewModel.returnLocationTitle(), todayTemperature: today.temp.day.deleteDecimal, today: viewModel.today?.weather)
            }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.backgroundColor = UIColor.clear
            return cell
        case 1:
            let cell = HourForecastTableViewCell()
            cell.selectionStyle = .none
            cell.fillUI(hourly: viewModel.hourly)
            cell.backgroundColor = UIColor.clear
            return cell
        case 2:
            let cell = DailyForecastTableViewCell()
            cell.selectionStyle = .none
            cell.fillUI(daily: viewModel.daily[indexPath.row])
            cell.backgroundColor = UIColor.clear
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension WeatherViewController: CellDelegate {
    
    func labelTapped() {
        tabBarController?.selectedIndex = 1
    }
}

extension WeatherViewController: CLLocationManagerDelegate {

    private func checkLocationPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            hideLocationPermissionView()
            showWeatherView()
        case .denied, .restricted:
            if isDetail {
                showLocationPermissionView()
                hideWeatherView()
            } else {
                hideLocationPermissionView()
                showWeatherView()
            }
        @unknown default:
            break
        }
    }
    
    @objc private func appWillEnterForeground() {
        checkLocationPermission()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
                hideLocationPermissionView()
                showWeatherView()
            case .denied, .restricted:
                if isDetail {
                    showLocationPermissionView()
                    hideWeatherView()
                } else {
                    hideLocationPermissionView()
                    showWeatherView()
                }
            @unknown default:
                break
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            viewModel.spesificLocation = ["lat": location.coordinate.latitude, "lon": location.coordinate.longitude]
            if isDetail {
                viewModel.fetchWeatherData(location: viewModel.spesificLocation)
                viewModel.returnLocation(location: viewModel.spesificLocation)
            }
        }
    }
    
    private func hideWeatherView() {
        weatherTableView.isHidden = true
        spinner.isHidden = true
    }
    
    func showLocationPermissionView() {
        imageView.isHidden = false
        titleLabel.isHidden = false
        messageLabel.isHidden = false
        settingsButton.isHidden = false
    }
    
    func hideLocationPermissionView() {
        imageView.isHidden = true
        titleLabel.isHidden = true
        messageLabel.isHidden = true
        settingsButton.isHidden = true
    }
}
