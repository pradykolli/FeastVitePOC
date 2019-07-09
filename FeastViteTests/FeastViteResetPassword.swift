//
//  FeastViteResetPassword.swift
//  FeastViteTests
//
//  Created by student on 7/1/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import XCTest
@testable import FeastVite
struct ChangePasswordRequest: Encodable {
    var email: String
    var newPassword: String
    var token: String
}
 var changePasswordRequest: ChangePasswordRequest!

class FeastViteResetPassword: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        changePasswordRequest = nil
        super.tearDown()

    }

    func testExample() {
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
