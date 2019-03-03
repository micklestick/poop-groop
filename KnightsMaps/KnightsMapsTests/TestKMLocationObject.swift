//
//  testKMLocationObject.swift
//  KnightsMapsTests
//
//  Created by Sean Hall on 2/28/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import XCTest
@testable import KnightsMaps

class TestKMLocationObject: XCTestCase {

    // This tests the creation of a location object using fake data
    
    func testLocationCreate() {
        
        let latitude: Float = 40.56
        let longitude: Float = -80.49
        
        let location = KMLocation(latitude: latitude, longitude: longitude)
        
        XCTAssert(location.latitude == latitude, "Latitidue created")
        XCTAssert(location.longitude == longitude, "longitude created")

    }
    
}
