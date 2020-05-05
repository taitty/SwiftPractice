//
//  testCalendarListModel.swift
//  googleCalendarTests
//
//  Created by 김희수 on 2020/05/06.
//  Copyright © 2020 taitty. All rights reserved.
//

import XCTest
@testable import googleCalendar

class testCalendarListModel: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetCalendarData() {
        
        let mockData = mockCalendarData()
        let dummyData = mockData.getMockCalendarData()
        
        let calendar = calendarListModel()
        let list = calendar.getCalendarList(calendarData: dummyData)
        
        XCTAssertNotNil(list, "list is nil")
    }

}
