//
//  CreateOrderPresenter.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/09.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol CreateOrderPresentationLogic {
    func presentSomething(response: CreateOrder.Something.Response)
}

class CreateOrderPresenter: CreateOrderPresentationLogic {
    weak var viewController: CreateOrderDisplayLogic?
    
    func presentSomething(response: CreateOrder.Something.Response) {
        let viewModel = CreateOrder.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}


