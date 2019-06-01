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
}

//Interactor -> Presenter
protocol PlacesInteractorOutPut: class {
    func didFetch(places: [Place])
    func didFetch(place: Place?)
}

class PlacesPresenter {
    
    weak var view: PlacesViewable?
    var interactor: PlacesInteractorInput
    var router: PlacesRouting
    
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
        view?.display(places: places)
    }
    
    func didFetch(place: Place?) {
        guard let place = place else {
            view?.display(error: "No place found")
            return
        }
        
        view?.display(new: place)
    }
    
}
