//
//  CitiesDataService.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/31/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation
import Realm

class CitiesDataService {
    
    
    //Load from JSON, not used right now
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
    
    static func getStaticList() {
        
    }
    
    
    static func getStaticCities(_ completion: ([City]) -> Void) {
        let results = City.allObjects()
        
        if results.count > 0 {
            var cities: [City] = []
            
            for index in 0 ..< results.count {
                let cityObject = results.object(at: index) as! RLMObject
                let city = City(object: cityObject)
                cities.append(city)
            }
            
            cities.sort { $0.current && !$1.current }
            completion(cities)
            
        } else {
            let staticCitiesId = [City(id: 2643743, name: "London", country: "GB", current: false),
                                  City(id: 1850147, name: "Tokyo", country: "JO", current: false)]
            
            let realm = RLMRealm.default()
            realm.beginWriteTransaction()
            realm.addObjects(staticCitiesId as NSArray)
            try? realm.commitWriteTransaction()
            
            completion(staticCitiesId)
        }
    }
    
    static func saveCurrentCity(place: Place) {
        let city = City(id: place.id,
                        name: place.name,
                        country: nil,
                        current: true)
        
        
        let realm = RLMRealm.default()
        realm.beginWriteTransaction()
        realm.add(city)
        try? realm.commitWriteTransaction()
    }
}
