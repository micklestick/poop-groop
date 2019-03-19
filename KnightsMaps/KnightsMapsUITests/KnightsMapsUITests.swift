//
//  KnightsMapsUITests.swift
//  KnightsMapsUITests
//
//  Created by Alec on 2/13/19.
//  Copyright © 2019 Alec. All rights reserved.
//
import UIKit
import XCTest

@testable import KnightsMaps

class KnightsMapsUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        //make sure our storyboard can load the different view controllers
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController = navigationController.topViewController as! ViewController
        
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(viewController.view)
        // this is the line responsible for the race condition
        NSRunLoop.mainRunLoop().runUntilDate(NSDate())

        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testDegreesAndRadians(){
        
        let view = ViewController()
        let rad = view.degreesToRadians(degrees: 90)
        XCTAssert(rad == 1.5708)
        
        let deg = view.radiansToDegrees(radians: 1.5708)
        XCTAssert(deg == 90.000200000000007)
        
    }
    
    func testBearingTo() {
        let view = ViewController()
        //location 2 should be directly south so bearing is almost -180 degrees
        let loc1 = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 28.587434545532343, longitude: -81.21362409345434), altitude: 0)
        let loc2 = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 28.588002671651058, longitude: -81.21443616420288), altitude: 0)
        let bearingInDegrees = view.getBearingBetweenTwoPoints(point1: loc1, point2: loc2)
        XCTAssert(bearingInDegrees == -179.69999999999999)
        
        
        
    }
    
    func testRounding() {
        
        let longDecimal = 9.432541543246435265
        let rounded4 = longDecimal.roundTo(places: 4)
        let rounded8 = longDecimal.roundTo(places: 8)
        XCTAssert(rounded4 == 9.4325)
        XCTAssert(rounded8 == 9.43254154)
        
        
    }
    
    func testDistanceLabel() {
        let app = XCUIApplication()
        let distanceLabel = app.labels["DistanceLabel"].label
        XCTAssertEqual(distanceLabel.text(), "Distance: 0.0m")
    }
    
    //test the search button
    func testSearchButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        let _ = vc.view

        //make sure the button is showing
        XCTAssertFalse(vc.searchButton.isHidden)
        
        //test the button delegate
        vc.buttonAction()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
