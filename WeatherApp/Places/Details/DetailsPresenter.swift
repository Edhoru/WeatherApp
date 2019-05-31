//
//  DetailsPresenter.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

//View -> Presenter
protocol DetailsPresentable: class {
    func viewDidLoad() -> Void
    func closeDetails()
}

//Interactor -> Presenter
protocol DetailsInteractorOutPut: class {
}


class DetailsPresenter {
    
    weak var view: DetailsView?
    var interactor: DetailsInteractorInput
    var router: DetailsRouting
    
    init(view: DetailsView, interactor: DetailsInteractorInput, router: DetailsRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}


extension DetailsPresenter: DetailsPresentable {
    
    func viewDidLoad() {
    }
    
    func closeDetails() {
        router.routeBack()
    }
    
}


extension DetailsPresenter: DetailsInteractorOutPut {
}
