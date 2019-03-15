//
//  TestBuildingObject.swift
//  KnightsMapsTests
//
//  Created by Sean Hall on 2/28/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import XCTest
@testable import KnightsMaps

class TestBuildingObject: XCTestCase {

    // This tests the creation of a building object using fake data

    func testBuildingCreate() {

        let buildingName = "Classroom building 2"
        let acronym = "CB2"
        let latitude: Float = 40.56
        let longitude: Float = -80.49
        let info = "Test string for information field"
        let type = "building"


        let building = KMBuilding(name: buildingName, acronym: acronym, latitude: latitude, longitude: longitude, info: info, type: type)

        XCTAssert(building.name == buildingName, "Building name")
        XCTAssert(building.acronym == acronym, "Acronym")
        XCTAssert(building.latitude == latitude, "Latitidue created")
        XCTAssert(building.longitude == longitude, "longitude created")
        XCTAssert(building.info == info, "info ")
        XCTAssert(building.type == type, "type")

    }

}
