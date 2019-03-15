//
//  TestDatabaseHelper.swift
//  KnightsMapsTests
//
//  Created by Sean Hall on 3/4/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import XCTest
@testable import KnightsMaps

class TestDatabaseHelper: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // function mimics version data to test if update function returns correct value
    // test passes if function returns true because 3.4 < 3.5
    
    func testNeedUpdateTrue() {
        
        let currentVersion: Float = 3.4
        let dbVersion: Float = 3.5
        let needUpdate: Bool = KMDatabaseHelper.needUpdate(localVersion: currentVersion, dbVersion: dbVersion)

        XCTAssert(needUpdate == true, "local needs update")

    }
    
    // function mimics version data to test if update function returns correct value
    // test passes if function returns false because 3.4 > 3.3
    
    func testNeedUpdateFalse() {
        let currentVersion: Float = 3.4
        let dbVersion: Float = 3.3
        let needUpdate: Bool = KMDatabaseHelper.needUpdate(localVersion: currentVersion, dbVersion: dbVersion)

        XCTAssert(needUpdate == false, "local does not needs update")

    }
    
    // tests that the function actually pulls and returns data in an array
    // run through the manual test described in the documentation and below to
    // check correctness. Test succeeds if the array is populated
    
    func testGetData() {
        var buildings : [KMBuilding] = []
        
        KMDatabaseHelper.getData {
            (array) in
            
            buildings.append(contentsOf: array)
            
            XCTAssert(buildings.count != 0, "Array Size 0")
        }
    }
    
    
    /* This test prints all the values of a building, the name, acronym, latitude, longitude,
     * info, and type. To run this test case follow instructions below
     * 1. Run the testGetDataCorrectness function below
     * 2. Check the console to make sure results printed
     * 3. Compare the output results from below to the objects stored in the JSON file
     *
     * if the objects are the same then the test is considered a success
     */
    func testGetDataCorrectness() {
        var buildings : [KMBuilding] = []
        
        KMDatabaseHelper.getData {
            (array) in
            
            buildings.append(contentsOf: array)
            
            for building in buildings {
                print(building.name, building.acronym, building.latitude, building.longitude, building.info, building.type)
            }
        }
    }

}
