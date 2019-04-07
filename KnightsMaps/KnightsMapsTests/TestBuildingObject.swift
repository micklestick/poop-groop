//
//  TestBuildingObject.swift
//  KnightsMapsTests
//
//  Created by Sean Hall on 2/28/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import XCTest
import CoreLocation
@testable import KnightsMaps

class TestBuildingObject: XCTestCase {
    var building: KMBuilding!
    let buildingName = "Classroom building 2"
    let acronym = "CB2"
    let latitude: Float = 40.56
    let longitude: Float = -80.49
    let info = "Test string for information field"
    let type = "building"
    
    override func setUp() {
        super.setUp()
        building = KMBuilding(name: buildingName, acronym: acronym, latitude: latitude, longitude: longitude, info: info, type: type)
    }

    // This tests the creation of a building object using fake data
    // Test will pass if each member of the building object is created and
    // if they match the given strings

    func testBuildingCreate() {
        XCTAssert(building != nil)
        XCTAssert(building.name == buildingName, "Building name")
        XCTAssert(building.acronym == acronym, "Acronym")
        XCTAssert(building.latitude == latitude, "Latitidue created")
        XCTAssert(building.longitude == longitude, "longitude created")
        XCTAssert(building.info == info, "info ")
        XCTAssert(building.type == type, "type")
    }
    
    // Test that the JSON serialization is performing as expected.
    func testBuildingCodable() {
        do {
            let data = try JSONEncoder().encode(building)
            building = try JSONDecoder().decode(KMBuilding.self, from: data)
        } catch let jsonErr {
            print("error serializing json:", jsonErr)
        }
        testBuildingCreate()
    }
    
    // Test that the generated location node has the correct coordinates.
    func testMakeNode() {
        let node = building.makeNode(45)
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(building.latitude), longitude: CLLocationDegrees(building.longitude))
        let location = CLLocation(coordinate: coordinate, altitude: 45)
        
        XCTAssert(node.location == location)
    }
}
