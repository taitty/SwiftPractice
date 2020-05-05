//
//  mockCalendarList.swift
//  googleCalendarTests
//
//  Created by 김희수 on 2020/05/06.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

class mockCalendarList {
    
    let sampleCalendarList: String = """
        {
            "items": [
                {
                    "id": "1055euhlsqsfj8cuhq32evmlvg@group.calendar.google.com",
                    "summary": "은행",
                },
                {
                    "id": "4recjm791liq7mvtpvppq20q0c@group.calendar.google.com",
                    "summary": "카드",
                },
                {
                    "id": "taitty@gmail.com",
                    "summary": "taitty@gmail.com",
                }
            ]
        }
    """
    
    func getMockCalendarList() -> [String: Any]? {
        let jsonData = Data(sampleCalendarList.utf8)
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
