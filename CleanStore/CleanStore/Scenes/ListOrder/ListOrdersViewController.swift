//
//  ListOrderViewController.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/20.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol ListOrdersDisplayLogic {
    func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel)
}

class ListOrdersViewController: UITableViewController, ListOrdersDisplayLogic {
    var interactor: ListOrdersBusinessLogic?
    var displayedOrders: [ListOrders.FetchOrders.ViewModel.DisplayedOrder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrdersOnLoad()
    }
    
    func fetchOrdersOnLoad() {
        let request = ListOrders.FetchOrders.Request()
        interactor?.fetchOrders(request: request)
    }
    
    func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel) {
        displayedOrders = viewModel.displayedOrders
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedOrders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedOrder = displayedOrders[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "OrderTableViewCell")
        }
        cell?.textLabel?.text = displayedOrder.date
        cell?.detailTextLabel?.text = displayedOrder.total
        return cell!
    }
}
