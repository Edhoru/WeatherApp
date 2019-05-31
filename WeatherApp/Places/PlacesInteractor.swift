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
}

class PlacesInteractor {
    
    weak var presenter: PlacesInteractorOutPut?
    
}

extension PlacesInteractor: PlacesInteractorInput {
    
    func getPlaces() {
        PlacesDataService.get { (places, error) in
            self.presenter?.didFetch(places: places)
        }
        
    }
}
