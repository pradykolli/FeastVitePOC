//
//  FeastViteTests.swift
//  FeastViteTests
//
//  Created by pradeep Kolli on 7/5/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import XCTest
@testable import FeastVite


class FeastViteTests: XCTestCase {
    var testObject:LoginViewController = LoginViewController()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
    }

    func testLogin() {
        let username = "test@gmail.com"
        let password = "Test@123"
        let isValid = testObject.loginUser(email: username, password: password)
        XCTAssertFalse( isValid )
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
