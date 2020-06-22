//
//  CreateOrderDataSource.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/08.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol CreateOrderBusinessLogic {
    var shippingMethods: [String] { get }
    
    func doSomething(request: CreateOrder.Something.Request)
    func formatExpirationDate(request: CreateOrder.FormatExpirationDate.Request)
}

protocol CreateOrderDataStore {
    var orderToEdit: Order { get set }
}

class CreateOrderInteractor: CreateOrderBusinessLogic, CreateOrderDataStore {
    var orderToEdit: Order
    var presenter: CreateOrderPresentationLogic?
    var worker: CreateOrderWorker?
    var shippingMethods = [
        "Standard Shipping",
        "Two-Day Shipping",
        "One-Day Shipping"
    ]
    var ordersWorker = OrdersWorker(ordersStore: OrdersMemStore())
    
    func createOrder(request: CreateOrder.CreateOrder.Request) {
        let orderToCreate = buildOrderFromOrderFormFields(request.orderFormFields)
        ordersWorker.createOrder(orderToCreate: orderToCreate) { (order: Order?) in
            self.orderToEdit = order
            let response = CreateOrder.CreateOrder.Response(order: order)
            self.presenter.presentCreatedOrder(response: response)
        }
    }
    
    func doSomething(request: CreateOrder.Something.Request) {
        worker = CreateOrderWorker()
        worker?.doSomeWork()
        
        let response = CreateOrder.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func formatExpirationDate(request: CreateOrder.FormatExpirationDate.Request) {
        let responde = CreateOrder.FormatExpirationDate.Response(date: request.date)
        presenter?.presentExpirationDate(response: responde)
    }
    
    private func buildOrderFromOrderFormFields(_ orderFormFields: CreateOrder.OrderFormFields) -> Order {
        let billingAddress = Address(street1: orderFormFields.billingAddressStreet1,
                                     street2: orderFormFields.billingAddressStreet2,
                                     city: orderFormFields.billingAddressCity,
                                     state: orderFormFields.billingAddressState,
                                     zip: orderFormFields.billingAddressZip)
        let paymentMethod = PaymentMethod(creditCardNumber: orderFormFields.paymentMethodCreditCardNumber,
                                          expirationDate: orderFormFields.paymentMethodExpirationDate,
                                          cvv: orderFormFields.paymentMethodCVV)
        let shipmentAddress = Address(street1: orderFormFields.shipmentAddressStreet1,
                                      street2: orderFormFields.shipmentAddressStreet2,
                                      city: orderFormFields.shipmentAddressCity,
                                      state: orderFormFields.shipmentAddressState,
                                      zip: orderFormFields.shipmentAddressZip)
        let shipmentMethod = ShipmentMethod(speed: ShipmentMethod.ShippingSpeed(rawValue: orderFormFields.shipmentMethodSpeed)!)
        
        return Order(date: orderFormFields.date,
                     total: orderFormFields.total,
                     email: orderFormFields.email,
                     id: orderFormFields.id,
                     firstName: orderFormFields.firstName,
                     lastName: orderFormFields.lastName,
                     phone: orderFormFields.phone,
                     billingAddress: billingAddress,
                     paymentMethod: paymentMethod,
                     shipmentAddress: shipmentAddress,
                     shipmentMethod: shipmentMethod)
    }
    
    func showOrderToEdit(request: CreateOrder.EditOrder.Request) {
        if let orderToEdit = orderToEdit {
            let response = CreateOrder.EditToOrder.Response(order: orderToEdit)
            presenter.presentOrderToEdit(response: response)
        }
    }
    
    func updateOrder(request: CreateOrder.UpdateOrder.Request) {
        
    }
}

