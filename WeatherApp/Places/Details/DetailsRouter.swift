//
//  Router.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

//Presenter -> Router
protocol DetailsRouting {
    
    func routeBack()
    
}

class DetailsRouter {
    var viewController: UIViewController
    
    init(view: UIViewController) {
        self.viewController = view
    }
}

extension DetailsRouter: DetailsRouting {
    
    func routeBack() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
