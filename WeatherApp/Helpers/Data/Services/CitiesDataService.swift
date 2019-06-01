//
//  CitiesDataService.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/31/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

class CitiesDataService {
    
    static func get(_ completion: @escaping ([City], Error?) -> Void) {
        guard let path = Bundle.main.path(forResource: "city.list", ofType: "json") else {
            fatalError("no file")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let broadcasts = map(from: data)
            completion(broadcasts, nil)
        } catch {
            fatalError("no data")
        }
    }
    
    
    private static func map(from data: Data) -> [City] {
        do {
            let broadcasts = try JSONDecoder().decode([City].self, from: data)
            return broadcasts
        } catch let jsonError {
            print("no json: ", jsonError)
            return []
        }
    }
}
