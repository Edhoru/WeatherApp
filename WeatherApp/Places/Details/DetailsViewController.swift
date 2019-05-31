//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

protocol DetailsView: class {
    func display(place: Place)
}

class DetailsViewController: UIViewController {
    
    var presenter: DetailsPresentable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .red
        
        print("Hello details")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    //Actions
    @objc func tapAction() {
        presenter?.closeDetails()
    }
    
}

extension DetailsViewController: DetailsView {
    
    func display(place: Place) {
        print(place)
    }
}
