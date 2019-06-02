//
//  PlacesInteractor.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation
import Realm

//Presenter -> Interactor
protocol PlacesInteractorInput {
    func getPlaces()
    func getPlace(lat: Double, lon: Double)
    func deleteUsersCity()
}

class PlacesInteractor {
    
    //Viper
    weak var presenter: PlacesInteractorOutPut?
    
    //Properties
    var isProcessingLocation = false
    var usersCityId: Int = 0
    
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
            self.isProcessingLocation = false
            
            guard let place = place else { return }
            CitiesDataService.saveCurrentCity(place: place)
            self.usersCityId = place.id
            
            
            self.presenter?.didFetch(place: place)
        }
    }
    
    func deleteUsersCity() {
        CitiesDataService.deleteCurrentCity(id: usersCityId) { (id) in
            self.presenter?.didDeleteUsersCity(id: id)
        }
    }
    
}
