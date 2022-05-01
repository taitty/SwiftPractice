//
//  Log.swift
//  myPhotoBrowser2
//
//  Created by 김희수 on 2022/04/29.
//

import Foundation
import os

class TraceError: Error {
    public let message: String
    
    public init(message: String = "") {
        self.message = message
    }
}

enum ServiceType: String {
    case UI = "UI"
    case SERVER = "SERVER"
    case DOMAIN = "DOMAIN"
    case UNTEST = "UNITTEST"
    case NONE = ""
}

class Log {
    static func Debug(_ serviceType: ServiceType, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let osLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: serviceType.rawValue)
        let message = "[\(file.components(separatedBy: "/").last ?? "")] [\(function)] [\(line)] \(message)"
        os_log(.default, log: osLog, "%@", message)
    }
}
