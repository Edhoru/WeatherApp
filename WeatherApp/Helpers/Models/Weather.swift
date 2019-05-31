//
//  Weather.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/31/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let description: String
    let icon: String
    let id: Float
    let main: String
}
