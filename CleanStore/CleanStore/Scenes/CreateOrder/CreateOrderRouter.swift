//
//  CreateOrderRouter.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/09.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

@objc protocol CreateOrderRoutingLogic {
    func routeToListOrders(segue: UIStoryboardSegue?)
}

protocol CreateOrderDataPassing {
    var dataStore: CreateOrderDataStore? { get }
}

class CreateOrderRouter: NSObject, CreateOrderRoutingLogic, CreateOrderDataPassing {
    weak var viewController: CreateOrderViewController?
    var dataStore: CreateOrderDataStore?
    
    func routeToListOrders(segue: UIStoryboardSegue?) {
//        if let segue = segue {
//            let destinationVC = segue.description as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//            navigateToSomewhere(source: viewController!, destination: destinationVC)
//        }
    }
//
//    func navigateToSomewhere(source: CreateOrderViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
//
//    func passDataToSomewhere(source: CreateOrderDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
