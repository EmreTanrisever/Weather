//
//  HeaderCellTableViewCell.swift
//  Weather
//
//  Created by Emre Tanrısever on 18.07.2024.
//

import UIKit

protocol TodayForecastTableViewCellProtocol: AnyObject {
    func changeUI()
}

protocol CellDelegate: AnyObject {
    func labelTapped()
}

final class TodayForecastTableViewCell: UITableViewCell {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Date")
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(named: "BackgroundColor")
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        return label
    }()
    
    private let weatherDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private lazy var viewModel = TodayForecastTableViewCellViewModel(view: self)
    
    weak var delegate: CellDelegate?
    
    required init(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented.")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}

extension TodayForecastTableViewCell {
    
    func configure(image: String, location: String, todayTemperature: String, today: [Weather]?) {
        viewModel.today = today
        
        contentView.addSubviews(locationLabel, dateLabel, weatherIconImageView, temperatureLabel, weatherDescription)
        
        weatherIconImageView.image = UIImage(named: ImageManager.shared.returnWeatherImage(imageName: image))
        
        locationLabel.text = location
        temperatureLabel.text = todayTemperature + "°"
        dateLabel.text = viewModel.returnDate()
        
        viewModel.changeUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        locationLabel.addGestureRecognizer(tapGesture)
        
        setConstraints()
    }
    
    @objc
    func labelTapped() {
        delegate?.labelTapped()
    }
}

extension TodayForecastTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 24),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            weatherIconImageView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
             weatherIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
             weatherIconImageView.widthAnchor.constraint(equalToConstant: 350),
             weatherIconImageView.heightAnchor.constraint(equalToConstant: 350),
            
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 8),
            
            weatherDescription.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 16),
            weatherDescription.topAnchor.constraint(equalTo: temperatureLabel.topAnchor),
            weatherDescription.bottomAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
        ])
    }
}

extension TodayForecastTableViewCell :TodayForecastTableViewCellProtocol {

    func changeUI() {
        guard let today = viewModel.today else { return }
        
        weatherDescription.textColor = UIColor(named: today.first!.main)
        weatherDescription.text = today.first!.main.localized
    }
}
