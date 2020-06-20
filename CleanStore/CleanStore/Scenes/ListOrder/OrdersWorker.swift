//
//  OrdersWorker.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/20.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol OrdersStoreProtocol {
    func fetchOrders(completionHandler: @escaping (() throws -> [Order]) -> Void)
}

class OrdersWorker {
    var ordersStore: OrdersStoreProtocol
    
    init(ordersStore: OrdersStoreProtocol) {
        self.ordersStore = ordersStore
    }
    
    func fetchOrders(completionHandler: @escaping ([Order]) -> Void) {
        ordersStore.fetchOrders { (orders: () throws -> [Order]) -> Void in
            do {
                let orders = try orders()
                DispatchQueue.main.async {
                    completionHandler(orders)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
}
