//
//  calendarListRepository.swift
//  googleCalendar
//
//  Created by 김희수 on 2020/05/01.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

class abstractCalendarListRepository {
    
    func getCalendarList() -> [String: Any]? {
        print("\(#function) is not implemented...")
        return nil
    }
    
    func getUserData() -> [String: Any]? {
        print("\(#function) is not implemented...")
        return nil
    }
    
    func setUserData() -> Int {
        print("\(#function) is not implemented...")
        return 0
    }
    
}

protocol calendarListRepository {
    func resolve() -> abstractCalendarListRepository
}

extension calendarListRepository {
    func resolve() -> abstractCalendarListRepository {
        return abstractCalendarListRepository()
    }
}



