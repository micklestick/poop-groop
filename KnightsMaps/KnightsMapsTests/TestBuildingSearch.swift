//
//  TestBuildingSearch.swift
//  KnightsMapsTests
//
//  Created by Isaac Vaughn on 4/7/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import XCTest
@testable import KnightsMaps

class TestBuildingSearch: XCTestCase {
    
    // A set of test buildings.
    func sampleBuildings() -> [KMBuilding] {
        
        let testPoint1 = KMBuilding(name: "Building 1", acronym: "b1", latitude: 28.588002671651058, longitude: -81.21443616420288, info: "Far building", type:"building")
        let testPoint2 = KMBuilding(name: "Building Across", acronym: "bbb", latitude: 28.587356572418223, longitude: -81.21317020973589, info: "Building across", type:"building")
        let testPoint3 = KMBuilding(name: "The Pool", acronym: "pul", latitude: 28.587804581020393, longitude: -81.21319605320281, info: "Da pool", type:"building")
        let testPoint4 = KMBuilding(name: "Building 2", acronym: "b2", latitude: 28.588017643782457, longitude: -81.2140559129889, info: "Da pool", type:"building")
        let testPoint5 = KMBuilding(name: "Building 3", acronym: "b3", latitude: 28.588235808274305, longitude: -81.2134356521542, info: "Da pool", type:"building")
        let testPoint6 = KMBuilding(name: "Building 4", acronym: "b4", latitude: 28.58765816795291, longitude: -81.21258998104895, info: "Da pool", type:"building")
        let testPoint7 = KMBuilding(name: "Basketball Court", acronym: "bc", latitude: 28.587876333190636, longitude: 81.21225001105631, info: "Da pool", type:"building")
        
        
        return [testPoint1, testPoint2, testPoint3, testPoint4, testPoint5, testPoint6, testPoint7]
    }
    
    func testBuildingSearch() {
        let buildingResult = SearchBuilding.searchArray(input: "Building 1", buildingArray: sampleBuildings())
        
        print(buildingResult)
        XCTAssert(buildingResult != nil)
        XCTAssert(buildingResult?.acronym == "b1")
        XCTAssert(buildingResult?.info == "Far building")
        XCTAssert(buildingResult?.type == "building")
    }
}
