//
//  TestBuildingView.swift
//  KnightsMapsTests
//
//  Created by Isaac Vaughn on 4/7/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import XCTest
@testable import KnightsMaps

class TestBuildingView: XCTestCase {
    
    func testViewCreate() {
        let view = BuildingView(name: "A_NAME")
        
        XCTAssert(view.buildingTitle.text == "A_NAME")
        XCTAssert(view.frame == CGRect(origin: CGPoint.zero, size: CGSize(width: 800, height: 100)))
        XCTAssert(view.buildingTitle.frame == CGRect(origin: CGPoint.zero, size: CGSize(width: 800, height: 100)))
        XCTAssert(view.backgroundColor == UIColor.clear)
        XCTAssert(view.layer.backgroundColor == UIColor.clear.cgColor)
        XCTAssert(view.layer.borderColor == UIColor(red:0.0, green:0.52, blue:1.0, alpha:1.0).cgColor)
        XCTAssert(view.layer.borderWidth == 10)
        XCTAssert(view.layer.cornerRadius == 40)
        XCTAssert(view.layer.masksToBounds == true)
        XCTAssert(view.buildingTitle.backgroundColor == UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.3))
        XCTAssert(view.buildingTitle.textAlignment == NSTextAlignment.center)
    }
}
