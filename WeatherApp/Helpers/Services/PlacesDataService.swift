//
//  Services.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

class PlacesDataService {
    
    static func get(_ completion: @escaping (_ places: [Place], Error?) -> Void) {
        completion([Place(name: "from data")], nil)
    }
    
}
