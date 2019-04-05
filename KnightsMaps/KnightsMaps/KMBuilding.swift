//
//  KMBuilding.swift
//  KnightsMaps
//
//  Created by Sean Hall on 2/14/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import Foundation

class KMBuilding: NSObject, Codable, NSCoding {
    let name: String
    let acronym: String
    let latitude: Float
    let longitude: Float
    let info: String
    let type: String

    init(name: String, acronym: String, latitude: Float,
         longitude: Float, info: String, type: String) {
        self.name = name
        self.acronym = acronym
        self.latitude = latitude
        self.longitude = longitude
        self.info = info
        self.type = type
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let acronym = aDecoder.decodeObject(forKey: "acronym") as! String
        let latitude = aDecoder.decodeFloat(forKey: "latitude")
        let longitude = aDecoder.decodeFloat(forKey: "longitude")
        let info = aDecoder.decodeObject(forKey: "info") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! String
        self.init(name: name, acronym: acronym, latitude: latitude, longitude: longitude, info: info, type: type)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(acronym, forKey: "acronym")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(info, forKey: "info")
        aCoder.encode(type, forKey: "type")

    }
}
