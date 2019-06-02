//
//  Services.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/30/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation
import Alamofire

class PlacesDataService {
    
    //Properties
    static private let key = "26bae33996b5ee5d6d30d4dc24d1b978"
    static private let url = "https://api.openweathermap.org/data/2.5/weather"
    static private let urlGroup = "https://api.openweathermap.org/data/2.5/group"
    static var temperatureUnit: String {
        get {
            let unitSystem = NSLocale.current.usesMetricSystem == true ? "metric" : "imperial"
            return unitSystem
        }
    }
    static let baseParameters = ["APPID": key,
                                 "units": temperatureUnit] as [String : Any]
    
    //Methods
    static func getBy(lat: Double, lon: Double, _ completion: @escaping (_ place: Place?, Error?) -> Void) {
        guard let url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(nil, nil)
            return
        }
        
        var parameters = baseParameters
        let extraParameters =  ["lat" : lat,
                                "lon":  lon]
        parameters.merge(dict: extraParameters)
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            guard let data = response.data else {
                completion(nil, nil)
                return
            }
            
            //            do {
            //                let a = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            //                print(a)
            //            }
            
            do {
                let place = try JSONDecoder().decode(Place.self, from: data)
                completion(place, nil)
            } catch let placeError {
                print(placeError)
                completion(nil, placeError)
            }
            
        }
    }
    
    
    static func getAll(_ completion: @escaping (_ places: [Place], Error?) -> Void) {
        guard let url = urlGroup.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion([], nil)
            return
        }
        
        var parameters = baseParameters
        CitiesDataService.getStaticCities { (staticCities, currentCityId) in
            let idsArray = staticCities.map({ "\($0.id)" })
            let extraParameters = ["id": idsArray.joined(separator: ",")]
            parameters.merge(dict: extraParameters)
            
            Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
                guard let data = response.data else {
                    completion([], nil)
                    return
                }
                //Debug info
                //                do {
                //                    let a = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                //                    print(a as Any)
                //                }
                
                
                do {
                    let placesListFetched = try JSONDecoder().decode(PlacesList.self, from: data)
                    let places = placesListFetched.list
                    let placesSorted = places.sorted(by: { (p1: Place, p2: Place) -> Bool in
                        return p1.id == currentCityId
                    })
                    completion(placesSorted, nil)
                    
                    
                } catch let placeError {
                    completion([], placeError)
                }
            }
            
        }
    }
    
}

