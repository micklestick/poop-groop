//
//  KMBuilding.swift
//  KnightsMaps
//
//  Created by Sean Hall on 2/14/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import Foundation

class KMBuilding {
    let name: String
    let acronym: String
    let location: KMLocation
    let info: String
    let type: String

    init(name: String, acronym: String, latitude: Float,
         longitude: Float, info: String, type: String) {
        self.name = name
        self.acronym = acronym
        self.location = KMLocation(latitude: latitude, longitude: longitude)
        self.info = info
        self.type = type
    }
}
