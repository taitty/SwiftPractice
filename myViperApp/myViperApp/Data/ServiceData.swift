//
//  ServiceData.swift
//  myViperApp
//
//  Created by 김희수 on 2021/11/05.
//

import Foundation

enum PageType: Int {
    
    case firstpage = 0
    case secondpage
    
    func description() -> String {
        switch self {
        case .firstpage:
            return "firstpage"
        case .secondpage:
            return "secondpage"
        }
    }
}

enum ErrorType: Int {

    case error_none = 0
    case error_wrong_page
    
    func description() -> String {
        switch self {
        case .error_none:
            return "there is no error"
        case .error_wrong_page:
            return "there is no page"
        }
    }
}
