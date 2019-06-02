//
//  PlaceCollectionViewCell.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 6/1/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit
import CoreLocation

class PlaceCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let iconWidth: CGFloat = 80
        static let space: CGFloat = 8
    }
    
    //Properties
    var place: Place!
    private let urlBase = "https://api.openweathermap.org/img/w/{icon}.png"
    
    
    //UI
    let emptyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    func setup(place: Place) {
        if place.isEmpty == true {
            displayEmpty()
        } else {
            display(place: place)
        }
    }
    
    private func displayEmpty() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedWhenInUse, .notDetermined, .authorizedAlways:
            emptyLabel.text = "Tap to add your location"
        case .restricted, .denied:
            emptyLabel.text = "Enable location in settings"
        @unknown default:
            emptyLabel.text = "Enable location in settings"
        }
        
        addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.topAnchor.constraint(equalTo: topAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.space),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.space),
            emptyLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func display(place: Place) {
        self.place = place
        
        nameLabel.text = place.name
        temperatureLabel.text = "\(place.main.temp)º"
        
        if let weather = place.weather.first {
            let imageService = ImageService()
            imageService.findImage(kind: .icon, value: weather.icon) { (image) in
                DispatchQueue.main.async {
                    self.iconImageView.image = image
                }
            }
        }
        
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(temperatureLabel)
        addSubview(iconImageView)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.space),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            temperatureLabel.widthAnchor.constraint(equalToConstant: Constants.iconWidth),
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconWidth),
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.space),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        
    }
}
