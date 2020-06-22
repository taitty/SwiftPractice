//
//  ListOrdersInteractor.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/20.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol ListOrdersBusinessLogic {
    func fetchOrders(request: ListOrders.FetchOrders.Request)
}

protocol ListOrdersDataStore {
    var orders: [Order] { get set }
}

class ListOrdersInteractor: ListOrdersBusinessLogic, ListOrdersDataStore {
    
    var presenter: ListOrdersPresentationLogic?
    var ordersWorker = OrdersWorker(ordersStore: OrdersMemStore())
    var orders: [Order] = []
    
    func fetchOrders(request: ListOrders.FetchOrders.Request) {
        ordersWorker.fetchOrders { (orders) -> Void in
            self.orders = orders
            let response = ListOrders.FetchOrders.Response(orders: orders)
            self.presenter?.presentFetchedOrders(response: response)
        }
    }
}
