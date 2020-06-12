//
//  CreateOrderDataSource.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/08.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol CreateOrderBusinessLogic {
    func doSomething(request: CreateOrder.Something.Request)
}

protocol CreateOrderDataStore {
    //var name: String { get set }
}

class CreateOrderInteractor: CreateOrderBusinessLogic, CreateOrderDataStore {
    var presenter: CreateOrderPresentationLogic?
    var worker: CreateOrderWorker?
    
    func doSomething(request: CreateOrder.Something.Request) {
        worker = CreateOrderWorker()
        worker?.doSomeWork()
        
        let response = CreateOrder.Something.Response()
        presenter.presentSomething(response: response)
    }
}

