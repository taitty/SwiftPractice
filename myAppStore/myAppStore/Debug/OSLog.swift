//
//  OSLog.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/01/27.
//

import os
import Foundation

enum ServiceType: String {
    case UI = "UI"
    case SERVER = "SERVER"
    case DOMAIN = "DOMAIN"
    case NONE = ""
}

class Log {
    static func Debug(_ serviceType: ServiceType, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let osLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: serviceType.rawValue)
        let message = "[\(file.components(separatedBy: "/").last ?? "")] [\(function)] [\(line)] \(message)"
        os_log(.default, log: osLog, "%@", message) //TODO: currently, "type" is set with ".default" to output to console
    }
}
