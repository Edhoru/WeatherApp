//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

protocol DetailsView: class {
}

class DetailsViewController: UIViewController {
    
    private enum Constants {
        static let closeWidth: CGFloat = 44
        static let iconWidth: CGFloat = 80
        static let space: CGFloat = 16
    }
    
    //VIPER
    var presenter: DetailsPresentable?
    let place: Place
    
    //UI
    let closeButton : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("x", for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 38)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 76)
        return label
    }()
    
    let temperatureMinLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let temperatureMaxLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let windKeyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Wind"
        return label
    }()
    
    let windLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let cloudKeyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Cloud"
        return label
    }()
    
    let cloudLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    init(place: Place) {
        self.place = place
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .red
        
        let closeSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(closeAction))
        closeSwipeRight.direction = .right
        view.addGestureRecognizer(closeSwipeRight)
        
        let closeSwipeDown = UISwipeGestureRecognizer(target: self, action: #selector(closeAction))
        closeSwipeDown.direction = .down
        view.addGestureRecognizer(closeSwipeDown)
        
        view.addSubview(closeButton)
        view.addSubview(nameLabel)
        view.addSubview(iconImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(temperatureMinLabel)
        view.addSubview(temperatureMaxLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(windKeyLabel)
        view.addSubview(cloudKeyLabel)
        view.addSubview(windLabel)
        view.addSubview(cloudLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: Constants.closeWidth),
            closeButton.widthAnchor.constraint(equalToConstant: Constants.closeWidth),
            closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constants.space / 2),
            closeButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.space / 2),
            
            nameLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.space),
            
            iconImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            iconImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.space),
            iconImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.space),
            
            temperatureLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 ),
            temperatureLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 ),
            temperatureLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.space),
            
            temperatureMinLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
            temperatureMinLabel.leadingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor),

            temperatureMaxLabel.heightAnchor.constraint(equalTo: temperatureMinLabel.heightAnchor),
            temperatureMaxLabel.widthAnchor.constraint(equalTo: temperatureMinLabel.widthAnchor),
            temperatureMaxLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
            temperatureMaxLabel.leadingAnchor.constraint(equalTo: temperatureMinLabel.trailingAnchor, constant: Constants.space),
            temperatureMaxLabel.trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: temperatureMinLabel.bottomAnchor, constant: Constants.space),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.space),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.space),
            
            windKeyLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.space * 2),
            windKeyLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.space),

            cloudKeyLabel.heightAnchor.constraint(equalTo: windKeyLabel.heightAnchor),
            cloudKeyLabel.widthAnchor.constraint(equalTo: windKeyLabel.widthAnchor),
            cloudKeyLabel.topAnchor.constraint(equalTo: windKeyLabel.topAnchor),
            cloudKeyLabel.leadingAnchor.constraint(equalTo: windKeyLabel.trailingAnchor, constant: Constants.space),
            cloudKeyLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.space),
            
            windLabel.topAnchor.constraint(equalTo: windKeyLabel.bottomAnchor, constant: Constants.space / 2),
            windLabel.leadingAnchor.constraint(equalTo: windKeyLabel.leadingAnchor),
            windLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Constants.space),
            
            cloudLabel.heightAnchor.constraint(equalTo: windLabel.heightAnchor),
            cloudLabel.widthAnchor.constraint(equalTo: windLabel.widthAnchor),
            cloudLabel.topAnchor.constraint(equalTo: windLabel.topAnchor),
            cloudLabel.leadingAnchor.constraint(equalTo: windLabel.trailingAnchor, constant: Constants.space),
            cloudLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.space),
            cloudLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Constants.space),
            
            ])
        
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        //Add info
        if let weather = place.weather.first {
            let imageService = ImageService()
            imageService.findImage(kind: .icon, value: weather.icon) { (image) in
                DispatchQueue.main.async {
                    self.iconImageView.image = image
                }
            }
            
            nameLabel.text = place.name
            temperatureLabel.text = "\(Int(place.main.temp))º"
            temperatureMinLabel.text = "\(Int(place.main.temp))º"
            temperatureMaxLabel.text = "\(Int(place.main.temp))º"
            descriptionLabel.text = weather.description
            windLabel.text = "\(place.wind.deg) - \(place.wind.speed)"
            cloudLabel.text = "\(place.clouds.all)"
            
        }
        
    }
    
    //Actions
    @objc func closeAction() {
        presenter?.closeDetails()
    }
    
}

extension DetailsViewController: DetailsView {
}
