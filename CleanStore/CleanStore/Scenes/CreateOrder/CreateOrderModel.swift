//
//  model.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/12.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

enum CreateOrder {
    enum Something {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum FormatExpirationDate {
        struct Request {
            var date: Date
        }
        
        struct Response {
            var date: Date
        }
        
        struct ViewModel {
            var date: String
        }
    }
}
