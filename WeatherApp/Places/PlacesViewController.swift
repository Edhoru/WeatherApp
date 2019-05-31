//
//  PlacesViewController.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

// Presenter -> View
protocol PlacesViewable: class {
    func display(places: [Place])
}

class PlacesViewController: UIViewController {
    
    //VIPER
    var presenter: PlacesPresentable?
    
    //Properties
    var places: [Place] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .green
        
        print("Hello viper")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    //Actions
    @objc func tapAction() {
        print(places)
        guard let place = self.places.first else {
            return
        }
        
        presenter?.select(place: place)
    }

}

extension PlacesViewController: PlacesViewable {
    
    func display(places: [Place]) {
        self.places = places
    }
    
}
