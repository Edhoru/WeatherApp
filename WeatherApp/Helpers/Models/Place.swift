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
