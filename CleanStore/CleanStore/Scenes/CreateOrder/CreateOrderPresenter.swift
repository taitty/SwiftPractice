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
    
    func presentCreateOrder(response: CreateOrder.CreateOrder.Response) {
        let viewModel = CreateOrder.CreateOrder.ViewModel(order: response.order)
        viewController?.displayCreatedOrder(viewModel: viewModel)
    }
    
    func presentOrderToEdit(response: CreateOrder.EditOrder.Response) {
        let orderToEdit = response.order
        let viewModel = CreateOrder.EditOrder.ViewModel(orderFormFields: CreateOrder.OrderFormFields())
        viewController?.displayOrderToEdit(viewModel: viewModel)
    }
    
    func presentUpdatedOrder(response: CreateOrder.UpdateOrder.Response) {
        let viewModel = CreateOrder.UpdateOrder.ViewModel(order: response.order)
        viewController?.displayUpdatedOrder(viewModel: viewModel)
    }
}


