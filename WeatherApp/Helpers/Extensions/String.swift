//
//  String.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 6/2/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

extension String {
    
    enum UnitKind {
        case cloud
        case temperature
        case wind
        
        var value: String {
            get {
                switch self {
                case .cloud:
                    return "%"
                case .temperature:
                    if Locale.current.usesMetricSystem == true {
                        return "ºc"
                    } else {
                        return "ºf"
                    }
                case .wind:
                    if Locale.current.usesMetricSystem == true {
                         return "meter/s"
                    } else {
                        return "miles/hour"
                    }
                }
            }
        }
    }
    
    func display(unit: UnitKind) -> String {
        let unit = unit.value
        return "\(self) \(unit)"
    }
    
}

//Capitalization
extension String {
    
    var capitalizeFirst: String {
        get {
            guard self.count > 1 else { return self }
            return prefix(1).uppercased() + dropFirst()
        }
    }
    
}
