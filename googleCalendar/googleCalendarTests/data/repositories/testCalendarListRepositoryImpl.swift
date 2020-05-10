//
//  testCalendarListRepositoryImpl.swift
//  googleCalendarTests
//
//  Created by 김희수 on 2020/05/11.
//  Copyright © 2020 taitty. All rights reserved.
//

import XCTest
@testable import googleCalendar

class testCalendarListRepositoryImpl: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetCalendarList() {
        let testIns = calendarListRepositoryImpl()
        let testRst = testIns.getCalendarList()
        
        XCTAssertNotNil(testRst, "list is nil")
    }
    
    func testGetUserData() {
        let testIns = calendarListRepositoryImpl()
        let testRst = testIns.getUserData()
        
        XCTAssertNotNil(testRst, "user data is nil")
    }
    
    func testSetUserData() {
        let testIns = calendarListRepositoryImpl()
        let testRst = testIns.setUserData()
        
        XCTAssertNotNil(testRst, "failed to set user data")
    }

}
