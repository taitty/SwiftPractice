//
//  CreateOrderDataSource.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/08.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol CreateOrderBusinessLogic {
    var shippingMethods: [String] { get }
    
    func doSomething(request: CreateOrder.Something.Request)
    func formatExpirationDate(request: CreateOrder.FormatExpirationDate.Request)
}

protocol CreateOrderDataStore {
    //var name: String { get set }
}

class CreateOrderInteractor: CreateOrderBusinessLogic, CreateOrderDataStore {
    var presenter: CreateOrderPresentationLogic?
    var worker: CreateOrderWorker?
    var shippingMethods = [
        "Standard Shipping",
        "Two-Day Shipping",
        "One-Day Shipping"
    ]
    
    func doSomething(request: CreateOrder.Something.Request) {
        worker = CreateOrderWorker()
        worker?.doSomeWork()
        
        let response = CreateOrder.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func formatExpirationDate(request: CreateOrder.FormatExpirationDate.Request) {
        let responde = CreateOrder.FormatExpirationDate.Response(date: request.date)
        presenter?.presentExpirationDate(response: responde)
    }
}

