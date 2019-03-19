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
