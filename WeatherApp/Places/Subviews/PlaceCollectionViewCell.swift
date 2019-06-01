//
//  PlaceCollectionViewCell.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 6/1/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let iconWidth: CGFloat = 80
        static let space: CGFloat = 8
    }
    
    //Properties
    var place: Place!
    private let urlBase = "https://api.openweathermap.org/img/w/{icon}.png"
    
    
    //UI
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
        self.place = place
        print(place)
        nameLabel.text = place.name
        temperatureLabel.text = "\(place.main.temp)º"
        
        if let weather = place.weather.first,
            let url = URL(string: urlBase.replacingOccurrences(of: "{icon}", with: weather.icon)) {
            
            let imageService = ImageService()
            imageService.findImage(with: url) { (image) in
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
