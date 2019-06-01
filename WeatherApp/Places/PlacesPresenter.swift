//
//  PlacesPresenter.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

//View -> Presenter
protocol PlacesPresentable: class {
    func viewDidLoad() -> Void
    func select(place: Place)
    func locateUser()
}

//Interactor -> Presenter
protocol PlacesInteractorOutPut: class {
    func didFetch(places: [Place])
    func didFetch(place: Place?)
}

class PlacesPresenter {
    
    //Properties
    weak var view: PlacesViewable?
    var interactor: PlacesInteractorInput
    var router: PlacesRouting
    var userLocationManager: UserLocation?
    
    init(view: PlacesViewable, interactor: PlacesInteractorInput, router: PlacesRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}


extension PlacesPresenter: PlacesPresentable {
    
    func viewDidLoad() {
        interactor.getPlaces()
    }
    
    func select(place: Place) {
        router.routeToDetails(place)
    }
    
}


extension PlacesPresenter: PlacesInteractorOutPut {
    
    func didFetch(places: [Place]) {
        guard places.count > 0 else {
            view?.display(errorMessage: "No places found")
            return
        }
        
        view?.display(places: places)
    }
    
    func didFetch(place: Place?) {
        guard let place = place else {
            view?.display(errorMessage: "No place found for location")
            return
        }
        
        view?.display(new: place)
    }
    
    func locateUser() {
        userLocationManager = UserLocation()
        userLocationManager?.get(delegate: self)
    }
    
}




//UserLocation
extension PlacesPresenter: UserLocationDelegate {
    
    func present(errorMessage: String) {
        view?.display(errorMessage: errorMessage)
    }
    
    
    func present(lat: Double, lon: Double) {        
        interactor.getPlace(lat: lat, lon: lon)
    }
}
