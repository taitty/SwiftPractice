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
    func displayExpirationDate(viewModel: CreateOrder.FormatExpirationDate.ViewModel)
}

class CreateOrderViewController: UITableViewController, CreateOrderDisplayLogic {
    var interactor: CreateOrderBusinessLogic?
    var router: (NSObjectProtocol & CreateOrderRoutingLogic & CreateOrderDataPassing)?
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var shippingMethodTextField: UITextField!
    @IBOutlet var shippingMethodPicker: UIPickerView!
    
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet var expirationDatePicker: UIDatePicker!
    
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
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shippingMethodPicker.dataSource = self
        shippingMethodPicker.delegate = self
        
        configurePickers()
        doSomething()
    }
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = CreateOrder.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CreateOrder.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
    @IBAction func expirationDatePickerValueChanged(_ sender: Any) {
        let date = expirationDatePicker.date
        let request = CreateOrder.FormatExpirationDate.Request(date: date)
        interactor?.formatExpirationDate(request: request)
    }
  
    func configurePickers() {
        shippingMethodTextField.inputView = shippingMethodPicker
        expirationDateTextField.inputView = expirationDatePicker
    }
    
    func displayExpirationDate(viewModel: CreateOrder.FormatExpirationDate.ViewModel) {
        let date = viewModel.date
        expirationDateTextField.text = date
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            for textField in textFields {
                if textField.isDescendant(of: cell) {
                    textField.becomeFirstResponder()
                }
            }
        }
    }
}

extension CreateOrderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return interactor?.shippingMethods.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return interactor?.shippingMethods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        shippingMethodTextField.text = interactor?.shippingMethods[row]
    }
}

extension CreateOrderViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let index = textFields.firstIndex(of: textField) {
            if index < textFields.count - 1 {
                let nextTextField = textFields[index + 1]
                nextTextField.becomeFirstResponder()
            }
        }
        return true
    }
    
}
