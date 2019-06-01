//
//  Place.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

struct Place: Codable {
    let id: Int
    let name: String
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
}

extension Place {
    
    static func empty() -> Place {
        let emptyPlace = Place(id: 0, name: "",
                               main: Main(humidity: 0, pressure: 0, temp: 0),
                               weather: [],
                               clouds: Clouds(all: 0),
                               wind: Wind(deg: 0, speed: 0))
        return emptyPlace
    }
}

