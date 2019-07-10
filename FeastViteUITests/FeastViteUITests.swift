//
//  FeastViteUITests.swift
//  FeastViteUITests
//
//  Created by pradeep Kolli on 7/5/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import XCTest
@testable import FeastVitePOC
class FeastViteUITests: XCTestCase {
    var app:XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserLogin() {
        let app = XCUIApplication()
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText("test@gmail.com")
        app.keyboards.buttons["Continue"].tap()
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("Test@123")
        app.buttons["Login"].tap()
        app.navigationBars["FeastVite.HomePageView"].buttons["Logout"].tap()
         
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testUserIdIsEmpty(){
        
        let app = XCUIApplication()
        app.textFields["Email"].tap()
        app.secureTextFields["Password"].tap()
        app.buttons["Login"].tap()
        app.alerts["Field Error"].buttons["OK"].tap()
        
    }

}
