//
//  ShowOrderRouter.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/22.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

@objc protocol ShowOrdersRoutingLogic {
    func routeToEditOrder(segue: UIStoryboardSegue?)
}

protocol ShowOrdersDataPassing {
    var dataStore: ShowOrderDataStore? { get }
}

class ShowOrdersRouter: NSObject, ShowOrdersRoutingLogic, ShowOrdersDataPassing {
    weak var viewController: ShowOrderViewController?
    var dataStore: ShowOrderDataStore?
    
    func routeToEditOrder(segue: UIStoryboardSegue?) {
        let destinationVC = segue!.destination as! CreateOrderViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToEditOrder(source: dataStore!, destination: &destinationDS)
        navigateToEditOrder(source: viewController!, destination: destinationVC)
    }
    
    func passDataToEditOrder(source: ShowOrderDataStore, destination: inout CreateOrderDataStore) {
        destination.orderToEdit = source.order
    }
    
    func navigateToEditOrder(source: ShowOrderViewController, destination: CreateOrderViewController) {
        
    }
}
