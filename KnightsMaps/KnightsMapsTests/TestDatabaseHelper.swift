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
    
    func testNeedUpdateTrue() {
        
        let currentVersion = 3.4
        let dbVersion = 3.5
        let needUpdate: Bool = KMDatabaseHelper.needUpdate(localVersion: currentVersion, dbVersion: dbVersion)

        XCTAssert(needUpdate == true, "local needs update")

    }
    
    // function mimics version data to test if update function returns correct value
    
    func testNeedUpdateFalse() {
        let currentVersion = 3.4
        let dbVersion = 3.3
        let needUpdate: Bool = KMDatabaseHelper.needUpdate(localVersion: currentVersion, dbVersion: dbVersion)

        XCTAssert(needUpdate == false, "local does not needs update")

    }

}
