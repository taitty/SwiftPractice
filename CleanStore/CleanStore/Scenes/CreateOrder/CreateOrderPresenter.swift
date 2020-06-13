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
    func presentExpirationDate(response: CreateOrder.FormatExpirationDate.Response)
}

class CreateOrderPresenter: CreateOrderPresentationLogic {
    var viewController: CreateOrderDisplayLogic?
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    func presentSomething(response: CreateOrder.Something.Response) {
        let viewModel = CreateOrder.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentExpirationDate(response: CreateOrder.FormatExpirationDate.Response) {
        let date = dateFormatter.string(from: response.date)
        let viewModel = CreateOrder.FormatExpirationDate.ViewModel(date: date)
        viewController?.displayExpirationDate(viewModel: viewModel)
    }
}


