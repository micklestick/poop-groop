//
//  KnightsMapsTests.swift
//  KnightsMapsTests
//
//  Created by Alec on 2/13/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import XCTest
@testable import KnightsMaps

class KnightsMapsTests: XCTestCase {
    var database: Database!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // try! should not be used for the main app, but the immediate error log is useful for testing.
        self.database = try! KMDatabase()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.database = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDatabase() {
        if self.database == nil {
            XCTAssert(false, "Database is nil.")
            return
        }
        
        let document: Dictionary = ["id": "myID"]
        do {
            try self.database.put("test", document)
        } catch { print("An error (\(error)) has occured.") }
//        XCTAssertEqual(try database.get("test", "myID"), document, "Database returned wrong object.")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
