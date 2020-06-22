//
//  ListOrdersPresenter.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/20.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol ListOrdersPresentationLogic {
    func presentFetchedOrders(response: ListOrders.FetchOrders.Response)
}

class ListOrdersPresenter: ListOrdersPresentationLogic {
    var viewController: ListOrdersDisplayLogic?
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    } ()
    let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    } ()
    
    func presentFetchedOrders(response: ListOrders.FetchOrders.Response) {
        var displayedOrders: [ListOrders.FetchOrders.ViewModel.DisplayedOrder] = []
        for order in response.orders {
            let date = dateFormatter.string(from: order.date!)
            let total = currencyFormatter.string(from: order.total!)
            let displayedOrder = ListOrders.FetchOrders.ViewModel.DisplayedOrder(id: order.id!, date: date, email: order.email, name: "\(order.firstName) \(order.lastName)", total: total!)
            displayedOrders.append(displayedOrder)
            let viewModel = ListOrders.FetchOrders.ViewModel(displayedOrders: displayedOrders)
            viewController?.displayFetchedOrders(viewModel: viewModel)
        }
    }
}
