//
//  DetailsInteractor.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

//Presenter -> Interactor
protocol DetailsInteractorInput {
    
}

class DetailsInteractor {
    
    weak var presenter: DetailsInteractorOutPut?
    
}

extension DetailsInteractor: DetailsInteractorInput {
    
}
