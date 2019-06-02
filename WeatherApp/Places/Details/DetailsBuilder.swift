//
//  File.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

class DetailsBuilder {
    
    static func build(place: Place) -> UIViewController {
        let view = DetailsViewController(place: place)
        let interactor = DetailsInteractor()
        let router = DetailsRouter(view: view)
        let presenter = DetailsPresenter(view: view,
                                        interactor: interactor,
                                        router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
}
