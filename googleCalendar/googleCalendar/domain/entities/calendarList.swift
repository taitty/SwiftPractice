//
//  calendarList.swift
//  googleCalendar
//
//  Created by 김희수 on 2020/04/30.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

class calendarList {
    var id: String?
    var summary: String?
    
    init(id: String, summary: String) {
        self.id = id
        self.summary = summary
    }
    
}

class deviceList {
    var duid: String?
    var calendarList: calendarList?
    
//    init(duid: String) {
//        self.duid = duid
//    }
}

class calendarAccount {
    var account: String?
    var provider: String?
    var token: String?
    var deviceList: deviceList?
    
//    init(account: String, provider: String, token: String) {
//        self.account = account
//        self.provider = provider
//        self.token = token
//    }
}

