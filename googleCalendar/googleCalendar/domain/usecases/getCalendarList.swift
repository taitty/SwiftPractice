//
//  getCalendarList.swift
//  googleCalendar
//
//  Created by 김희수 on 2020/05/01.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

class getCalendarList {
    
    func getCalendarList(list: [String: Any]?) -> [String: Any]? {
        print("\(#file) \(#line) \(#function)")
        
        guard let list = list else {
            print("calendarList is nil")
            return nil
        }

        return list
    }
    
    
    
}
