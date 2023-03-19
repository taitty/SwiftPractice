//
//  Log.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/19.
//

import os
import Foundation

enum ServiceType: String {
    case UI = "UI"
    case INFRA = "INFRA"
    case DOMAIN = "DOMAIN"
    case NONE = ""
}

struct Log {
    static func Debug(_ serviceType: ServiceType, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let osLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: serviceType.rawValue)
        let message = "[\(file.components(separatedBy: "/").last ?? "")] [\(function)] [\(line)] \(message)"
        os_log(.default, log: osLog, "%@", message) //TODO: currently, "type" is set with ".default" to output to console
    }
}

struct TraceError: Error {
    public let message: String
    public let code: String
    
    public init(message: String = "", code: String = "") {
        self.message = message
        self.code = code
    }
}
