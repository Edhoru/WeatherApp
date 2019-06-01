//
//  Dictionary.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 6/1/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

extension Dictionary {
    
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
    
}
