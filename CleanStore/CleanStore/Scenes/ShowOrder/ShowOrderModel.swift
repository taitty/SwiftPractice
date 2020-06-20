//
//  ShowOrderModel.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/21.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

enum ShowOrder {
    enum GetOrder {
        struct Request {
            
        }
        
        struct Response {
            var order: Order
        }
        
        struct ViewModel {
            struct DisplayedOrder {
                var id: String
                var date: String
                var email: String
                var name: String
                var total: String
            }
            var displayedOrder: DisplayedOrder
        }
    }
}
