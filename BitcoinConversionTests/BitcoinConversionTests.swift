//
//  BitcoinConversionTests.swift
//  BitcoinConversionTests
//
//  Created by Antonio Mayorga on 5/2/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import XCTest
@testable import BitcoinConversion

class BitcoinConversionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserNameIsSaved() {
        let enterNameVC = EnterNameViewController()
        enterNameVC.enteredName = "Daniel"
        enterNameVC.defaults.set(enterNameVC.enteredName, forKey: "Name")
        let savedName = enterNameVC.defaults.object(forKey: "Name") as! String
        XCTAssertEqual(savedName, "Daniel")
    }
}
