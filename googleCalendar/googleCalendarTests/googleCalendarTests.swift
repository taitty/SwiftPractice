//
//  googleCalendarTests.swift
//  googleCalendarTests
//
//  Created by 김희수 on 2020/05/01.
//  Copyright © 2020 taitty. All rights reserved.
//

import XCTest
@testable import googleCalendar

class googleCalendarTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    func testGetCalendarData() {
        
        let mockInstance = mockGetCalendarList()
        let list = mockInstance.mockGetCalendarData()
        
        XCTAssertNotNil(list, "list is nil")
        
    }
    
}
