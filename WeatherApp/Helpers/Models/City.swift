//
//  City.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 5/31/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation
import Realm

class City: RLMObject, Codable {
    @objc dynamic var id: Int = 1
    @objc dynamic var name: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var current: Bool = false
    
    override open class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, name: String, country: String?, current: Bool) {
        self.init()
        
        self.id = id
        self.name = name
        self.country = country ?? ""
        self.current = current
    }
    
    convenience init(object: RLMObject) {
        self.init()
        
        self.id = object["id"] as! Int
        self.name = object["name"] as! String
        self.country = object["country"] as! String        
        self.current = object["current"] as! Bool
    }
}
