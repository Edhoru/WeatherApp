//
//  Router.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

//Presenter -> Router
protocol PlacesRouting {
    
    func routeToDetails(_ place: Place)
    
}

class PlacesRouter {
    var viewController: UIViewController
    
    init(view: UIViewController) {
        self.viewController = view
    }
}

extension PlacesRouter: PlacesRouting {
    
    func routeToDetails(_ place: Place) {
        let detailsView = DetailsBuilder.build()
        viewController.present(detailsView, animated: true, completion: nil)
    }
}
