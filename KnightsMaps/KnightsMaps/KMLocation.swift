//
//  KMLocation.swift
//  KnightsMaps
//
//  Created by Sean Hall on 2/15/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import Foundation

// Custom location class for storing latitude and longitude as one object
class KMLocation {
    let latitude: Float
    let longitude: Float
    
    init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
