//
//  File.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class PlacesBuilder {
    
    static func build() -> UIViewController {
        let view = PlacesViewController()
        let interactor = PlacesInteractor()
        let router = PlacesRouter(view: view)
        let presenter = PlacesPresenter(view: view,
                                        interactor: interactor,
                                        router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
}
