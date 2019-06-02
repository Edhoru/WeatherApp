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
    func removeCity(id: Int)
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
    
    let actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
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
        view.addSubview(actionButton)
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),

            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            actionButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            actionButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -16)
            ])
    }
    
    func setupActionButton() {
        CitiesDataService.getStaticCities { (cities, _) in
            if cities.filter({ $0.current == true }).count > 0 {
                self.actionButton.setTitle("Remove the current city", for: .normal)
                self.actionButton.backgroundColor = .red
                actionButton.removeTarget(self, action: #selector(addPlaceAction), for: .touchUpInside)
                actionButton.addTarget(self, action: #selector(removePlaceAction), for: .touchUpInside)
            } else {
                self.actionButton.setTitle("A your current city", for: .normal)
                self.actionButton.backgroundColor = .blue
                actionButton.removeTarget(self, action: #selector(removePlaceAction), for: .touchUpInside)
                actionButton.addTarget(self, action: #selector(addPlaceAction), for: .touchUpInside)
            }
        }
    }
    
    //Actions
    @objc func addPlaceAction() {
        activityIndicator.startAnimating()
        presenter?.locateUser()
    }
    
    @objc func removePlaceAction() {
        presenter?.removeUsersPlace()
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
        
        setupActionButton()
        activityIndicator.stopAnimating()
    }
    
    func display(new place: Place) {
        places.insert(place, at: 0)
        collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
        
        setupActionButton()
        activityIndicator.stopAnimating()
    }
    
    func display(errorMessage: String) {
        activityIndicator.stopAnimating()
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try again", style: .default) { (action) in
            self.presenter?.viewDidLoad()
            alertController.dismiss(animated: true, completion: {
                self.activityIndicator.startAnimating()
            })
        }
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    func removeCity(id: Int) {
        places = places.filter({ $0.id != id })
        collectionView.deleteItems(at: [IndexPath(item: 0, section: 0)])
        
        setupActionButton()
        activityIndicator.stopAnimating()
    }
    
}
