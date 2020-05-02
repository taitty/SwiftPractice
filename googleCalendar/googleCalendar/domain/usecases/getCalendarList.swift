//
//  getCalendarList.swift
//  googleCalendar
//
//  Created by 김희수 on 2020/05/01.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

class getCalendarList {
    
    func getCalendarData() -> [String: Any]? {
        print("\(#file) \(#line) \(#function)")
        
        return nil
    }
    
    func getCalendarList(calendarData: [String: Any]) -> [[String: Any]]? {
        print("\(#file) \(#line) \(#function)")
        
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
