//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let weatherTableViewIdentifier = "WeatherTableViewIdentifier"

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented.")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
}

extension WeatherTableViewCell {
    
    func configure() {
        contentView.addSubviews(dayLabel, minTempLabel, maxTempLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            minTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            minTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            minTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            maxTempLabel.trailingAnchor.constraint(equalTo: minTempLabel.leadingAnchor, constant: -24),
            maxTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            maxTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func fill(data: Daily) {
        dayLabel.text = "\(data.dt.getDay)"
        minTempLabel.text = data.temp.min.deleteDecimal + "°"
        maxTempLabel.text = data.temp.max.deleteDecimal + "°"
    }
}
