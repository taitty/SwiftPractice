//
//  ShowOrderPresenter.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/21.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol ShowOrderPresentationLogic {
    func presentOrder(response: ShowOrder.GetOrder.Response)
}

class ShowOrderPresenter: ShowOrderPresentationLogic {
    var viewController: ShowOrderDisplayLogic?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()
    
    func presentOrder(response: ShowOrder.GetOrder.Response) {
        let order = response.order
        let date = dateFormatter.string(from: order.date)
        let total = currencyFormatter.string(from: order.total)!
        let displayedOrder = ShowOrder.GetOrder.ViewModel.DisplayedOrder(
            id: order.id!,
            date: date,
            email: order.email,
            name: "\(order.firstName) \(order.lastName)",
            total: total
        )
        let viewModel = ShowOrder.GetOrder.ViewModel(displayedOrder: displayedOrder)
        viewController?.displayOrder(viewModel: viewModel)
    }
}
