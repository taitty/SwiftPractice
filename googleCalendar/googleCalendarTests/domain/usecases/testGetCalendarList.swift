//
//  testGetCalendarList.swift
//  googleCalendarTests
//
//  Created by 김희수 on 2020/05/06.
//  Copyright © 2020 taitty. All rights reserved.
//

import XCTest
@testable import googleCalendar

class testGetCalendarList: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetCalendarList() {
        
        let mockData = mockCalendarList()
        let dummyData = mockData.getMockCalendarList()
        
        let calendar = getCalendarList()
        let list = calendar.getCalendarList(list: dummyData)
        
        XCTAssertNotNil(list, "list is nil")
    }


}
