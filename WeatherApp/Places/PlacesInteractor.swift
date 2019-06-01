//
//  PlacesInteractor.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation
import CoreLocation

//Presenter -> Interactor
protocol PlacesInteractorInput {
    func getPlaces()
    func getPlace(location: CLLocation)
}

class PlacesInteractor {
    
    weak var presenter: PlacesInteractorOutPut?
    
}

extension PlacesInteractor: PlacesInteractorInput {
    
    func getPlaces() {        
        PlacesDataService.getAll() { (places, error) in
            self.presenter?.didFetch(places: places)
        }
        
    }
    
    func getPlace(location: CLLocation) {
        PlacesDataService.getBy(location: location) { (place, error) in
            self.presenter?.didFetch(place: place)
        }
    }
}
