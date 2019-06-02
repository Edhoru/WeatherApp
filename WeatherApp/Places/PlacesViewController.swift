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
    func display(new place: Place)
    func display(errorMessage: String)
}

class PlacesViewController: UIViewController {
    
    //VIPER
    var presenter: PlacesPresentable?
    
    //Properties
    var places: [Place] = []
    
    // UI
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .background
        collectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
    }

}

//Collection view

extension PlacesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let place = places[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlaceCollectionViewCell
        cell.setup(place: place)
        return cell
    }
    
}


extension PlacesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        
        if place.isEmpty == true {
            presenter?.locateUser()
        } else {
            presenter?.select(place: place)
        }
    }
}


//Viper
extension PlacesViewController: PlacesViewable {
    
    func display(places: [Place]) {
        self.places = places
        collectionView.reloadData()
    }
    
    func display(new place: Place) {
        places[0] = place
        collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])        
    }
    
    func display(errorMessage: String) {
        print(errorMessage)
    }
    
}
