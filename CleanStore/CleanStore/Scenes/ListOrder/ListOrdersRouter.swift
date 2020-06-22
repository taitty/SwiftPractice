//
//  ListOrdersRouter.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/22.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

@objc protocol ListOrdersRoutingLogic {
    func routeToCreateOrder(segue: UIStoryboardSegue?)
    func routeToShowOrder(segue: UIStoryboardSegue?)
}

protocol ListOrdersDataPassing {
    var dataStore: ListOrdersDataStore? { get }
}

class ListOrdersRouter: NSObject, ListOrdersRoutingLogic, ListOrdersDataPassing {
    weak var viewController: ListOrdersViewController?
    var dataStore: ListOrdersDataStore?
    
    func routeToCreateOrder(segue: UIStoryboardSegue?) {
        let destinationVC = segue!.destination as! CreateOrderViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToCreateOrder(source: dataStore!, destination: &destinationDS)
        navigateToCreateOrder(source: viewController!, destination: destinationVC)
    }
    
    func passDataToCreateOrder(source: ListOrdersDataStore, destination: inout CreateOrderDataStore) {
        
    }
    
    func navigateToCreateOrder(source: ListOrdersViewController, destination: CreateOrderViewController) {
        
    }
    
    func routeToShowOrder(segue: UIStoryboardSegue?) {
        let destinationVC = segue!.destination as! ShowOrderViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToShowOrder(source: dataStore!, destination: &destinationDS)
        navigateToShowOrder(source: viewController!, destination: destinationVC)
    }
    
    func passDataToShowOrder(source: ListOrdersDataStore, destination: inout ShowOrderDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.order = source.orders[selectedRow!]
    }
    
    func navigateToShowOrder(source: ListOrdersViewController, destination: ShowOrderViewController) {
        
    }
}
