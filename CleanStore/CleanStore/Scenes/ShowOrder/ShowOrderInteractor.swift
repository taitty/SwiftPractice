//
//  ShowOrderInteractor.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/21.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol ShowOrderBusinessLogic {
    func getOrder(request: ShowOrder.GetOrder.Request)
}

protocol ShowOrderDataSource {
    
}

class ShowOrderInteractor: ShowOrderBusinessLogic, ShowOrderDataSource {
    var presenter: ShowOrderPresentationLogic?
    var order: Order!
    
    func getOrder(request: ShowOrder.GetOrder.Request) {
        let response = ShowOrder.GetOrder.Response(order: order)
        presenter?.presentOrder(response: response)
    }
}
