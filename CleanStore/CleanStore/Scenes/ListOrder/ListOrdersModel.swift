//
//  ListOrderModel.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/20.
//  Copyright © 2020 taitty. All rights reserved.
//

import Foundation

struct Order {
    var date: Date?
    var total: NSNumber?
    var email: String?
    var id: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var billingAddress: Address
    var paymentMethod: String?
    var shipmentAddress: Address
    var shipmentMethod: String?
}

enum ListOrders {
    enum FetchOrders {
        struct Request {
            
        }
        
        struct Response {
            var orders: [Order]
        }
        
        struct ViewModel {
            struct DisplayedOrder {
                var id: String
                var date: String
                var email: String
                var name: String
                var total: String
            }
            var displayedOrders: [DisplayedOrder]
        }
    }
}
