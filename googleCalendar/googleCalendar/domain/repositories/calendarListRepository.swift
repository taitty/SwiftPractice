//
//  calendarListRepository.swift
//  googleCalendar
//
//  Created by 김희수 on 2020/05/01.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

protocol calendarListRepository {
    func getCalendarList() -> [String: Any]?
    func getUserData() -> [String: Any]?
    func setUserData() -> Int
}
