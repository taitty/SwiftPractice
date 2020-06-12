//
//  File.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/08.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol CreateOrderDisplayLogic {
    func displaySomething(viewModel: CreateOrder.Something.ViewModel)
}

class CreateOrderViewController: UITableViewController, CreateOrderDisplayLogic {
    var interactor: CreateOrderBusinessLogic?
    var router: (NSObjectProtocol & CreateOrderRoutingLogic & CreateOrderDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = CreateOrderInteractor()
        let presenter = CreateOrderPresenter()
        let router = CreateOrderRouter()
        
        viewController.interactor = interactor
        viewController.router = router
    
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.response(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = CreateOrder.Something.Request()
        interactor.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CreateOrder.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
