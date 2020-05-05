//
//  mockCalendarData.swift
//  googleCalendarTests
//
//  Created by 김희수 on 2020/05/06.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

class mockCalendarData {
    
    let sampleCalendarData: String = """
        {
         "kind": "calendar#calendarList",
         "etag": "p338b3jvjlq4ui0g",
         "nextSyncToken": "CNCxz_OuiekCEhB0YWl0dHlAZ21haWwuY29t",
         "items": [
          {
           "kind": "calendar#calendarListEntry",
           "etag": "1562088717959000",
           "id": "1055euhlsqsfj8cuhq32evmlvg@group.calendar.google.com",
           "summary": "은행",
           "timeZone": "Asia/Seoul",
           "colorId": "24",
           "backgroundColor": "#a47ae2",
           "foregroundColor": "#000000",
           "selected": true,
           "accessRole": "owner",
           "defaultReminders": [],
           "conferenceProperties": {
            "allowedConferenceSolutionTypes": [
             "eventHangout"
            ]
           }
          },
          {
           "kind": "calendar#calendarListEntry",
           "etag": "1562088719391000",
           "id": "4recjm791liq7mvtpvppq20q0c@group.calendar.google.com",
           "summary": "카드",
           "timeZone": "Asia/Seoul",
           "colorId": "17",
           "backgroundColor": "#9a9cff",
           "foregroundColor": "#000000",
           "selected": true,
           "accessRole": "owner",
           "defaultReminders": [],
           "conferenceProperties": {
            "allowedConferenceSolutionTypes": [
             "eventHangout"
            ]
           }
          },
          {
           "kind": "calendar#calendarListEntry",
           "etag": "1554998079069000",
           "id": "isongi78@gmail.com",
           "summary": "isongi78@gmail.com",
           "timeZone": "Asia/Seoul",
           "colorId": "12",
           "backgroundColor": "#fad165",
           "foregroundColor": "#000000",
           "selected": true,
           "accessRole": "reader",
           "defaultReminders": [],
           "conferenceProperties": {
            "allowedConferenceSolutionTypes": [
             "eventHangout"
            ]
           }
          },
          {
           "kind": "calendar#calendarListEntry",
           "etag": "1562088719954000",
           "id": "taitty@gmail.com",
           "summary": "taitty@gmail.com",
           "timeZone": "Asia/Seoul",
           "colorId": "13",
           "backgroundColor": "#92e1c0",
           "foregroundColor": "#000000",
           "selected": true,
           "accessRole": "owner",
           "defaultReminders": [
            {
             "method": "popup",
             "minutes": 60
            }
           ],
           "notificationSettings": {
            "notifications": [
             {
              "type": "eventCreation",
              "method": "email"
             },
             {
              "type": "eventChange",
              "method": "email"
             },
             {
              "type": "eventCancellation",
              "method": "email"
             }
            ]
           },
           "primary": true,
           "conferenceProperties": {
            "allowedConferenceSolutionTypes": [
             "eventHangout"
            ]
           }
          },
          {
           "kind": "calendar#calendarListEntry",
           "etag": "1562088718965000",
           "id": "ko.south_korea#holiday@group.v.calendar.google.com",
           "summary": "대한민국의 휴일",
           "timeZone": "Asia/Seoul",
           "colorId": "3",
           "backgroundColor": "#f83a22",
           "foregroundColor": "#000000",
           "selected": true,
           "accessRole": "reader",
           "defaultReminders": [],
           "conferenceProperties": {
            "allowedConferenceSolutionTypes": [
             "eventHangout"
            ]
           }
          }
         ]
        }
    """
    
    func getMockCalendarData() -> [String: Any]? {
        let jsonData = Data(sampleCalendarData.utf8)
        do {
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return json
            }
        } catch {
            print("failed to convert json")
        }
        
        return nil
    }
}
