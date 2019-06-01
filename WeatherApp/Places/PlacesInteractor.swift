//
//  PlacesInteractor.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

//Presenter -> Interactor
protocol PlacesInteractorInput {
    func getPlaces()
    func getPlace(lat: Double, lon: Double)
}

class PlacesInteractor {
    
    //Viper
    weak var presenter: PlacesInteractorOutPut?
    
    //Properties
    var isProcessingLocation = false
    
}

extension PlacesInteractor: PlacesInteractorInput {
    
    func getPlaces() {        
        PlacesDataService.getAll() { (places, error) in
            self.presenter?.didFetch(places: places)
        }
        
    }
    
    func getPlace(lat: Double, lon: Double) {        
        guard isProcessingLocation == false else {
            return
        }
        
        isProcessingLocation = true
        PlacesDataService.getBy(lat: lat, lon: lon) { (place, error) in
            self.presenter?.didFetch(place: place)
        }
    }
}
