//
//  HeaderCellTableViewCell.swift
//  Weather
//
//  Created by Emre Tanrısever on 18.07.2024.
//

import UIKit

final class TodayForecastTableViewCell: UITableViewCell {
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.systemGray2.cgColor
        imageView.layer.borderWidth = 1
        imageView.backgroundColor = UIColor.systemGray3
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "24°"
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    
    required init(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented.")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}

extension TodayForecastTableViewCell {
    
    func configure(image: Data, location: String, todayTemperature: String) {
        
        contentView.addSubviews(locationLabel, weatherIconImageView, temperatureLabel)
        
        weatherIconImageView.image = UIImage(data: image)
        locationLabel.text = location
        temperatureLabel.text = todayTemperature + "°"
        
        setConstraints()
    }
}

extension TodayForecastTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            weatherIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 100),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 100),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
