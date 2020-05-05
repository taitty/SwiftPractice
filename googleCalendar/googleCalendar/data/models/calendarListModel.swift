//
//  calendarListModel.swift
//  googleCalendar
//
//  Created by 김희수 on 2020/05/06.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

class calendarListModel {

    func getCalendarList(calendarData: [String: Any]?) -> [[String: Any]]? {
        print("\(#file) \(#line) \(#function)")
        
        guard let calendarData = calendarData else {
            print("calendarData is nil")
            return nil
        }
        
        guard let items = calendarData["items"] as? [[String: Any]] else {
            print("failed to get items")
            return nil
        }
        
        var calendarList = [[String: Any]]()
        for item in items {
            var calendar = Dictionary<String, Any>()
            calendar["id"] = item["id"]
            calendar["summary"] = item["summary"]
            calendarList.append(calendar)
        }
        
        return calendarList
    }
}
