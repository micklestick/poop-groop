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

    // This tests the creation of a building object using fake data
    // MUST RUN AFTER LOCATION TEST as it is dependent on the location
    // object being created

    func testBuildingCreate() {

        let buildingName = "Classroom building 2"
        let acronym = "CB2"
        let latitude: Float = 40.56
        let longitude: Float = -80.49
        let info = "Test string for information field"


        let building = KMBuilding(name: buildingName, acronym: acronym, latitude: latitude,
                                  longitude: longitude, info: info)

        XCTAssert(building.name == buildingName, "Building name")
        XCTAssert(building.acronym == acronym, "Acronym")
        XCTAssert(building.location.latitude == latitude, "Latitidue created")
        XCTAssert(building.location.longitude == longitude, "longitude created")
        XCTAssert(building.info == info, "info ")

    }

}
