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
    static var temperatureUnit: String {
        get {
            let metric = NSLocale.current.usesMetricSystem == true ? "metric" : "imperial"
            return metric
        }
    }
    
    
    //Methods
    static func get(_ completion: @escaping (_ places: [Place], Error?) -> Void) {
        guard let url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion([], nil)
            return
        }
//        let parameters = ["q" : "London",
//                          "APPID" : key]
        let parameters = ["lat" : 19.519009,
                          "lon":  -96.870218,
                          "APPID" : key,
                          "units" : self.temperatureUnit] as [String : Any]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            guard let data = response.data else {
                completion([], nil)
                return
            }
            
//            do {
//                let a = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(a)
//            }
            
            do {
                let place = try JSONDecoder().decode(Place.self, from: data)
                completion([place], nil)
            } catch let placeError {
                print(placeError)
                completion([], placeError)
            }
            
        }
    }
    
}
