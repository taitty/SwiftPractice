//
//  ShowOrderViewController.swift
//  CleanStore
//
//  Created by 김희수 on 2020/06/20.
//  Copyright © 2020 taitty. All rights reserved.
//

import UIKit

protocol ShowOrderDisplayLogic {
    func displayOrder(viewModel: ShowOrder.GetOrder.ViewModel)
}

class ShowOrderViewController: UIViewController, ShowOrderDisplayLogic {
    
    @IBOutlet weak var labelOrderID: UILabel!
    @IBOutlet weak var labelOrderDate: UILabel!
    @IBOutlet weak var labelOrderEmail: UILabel!
    @IBOutlet weak var labelOrderName: UILabel!
    @IBOutlet weak var labelOrderTotal: UILabel!
 
    var interactor: ShowOrderBusinessLogic?
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getOrder()
    }
    
    func getOrder() {
        let request = ShowOrder.GetOrder.Request()
        interactor?.getOrder(request: request)
    }
    
    func displayOrder(viewModel: ShowOrder.GetOrder.ViewModel) {
        let displayedOrder = viewModel.displayedOrder
        labelOrderID.text = displayedOrder.id
        labelOrderDate.text = displayedOrder.date
        labelOrderEmail.text = displayedOrder.email
        labelOrderName.text = displayedOrder.name
        labelOrderTotal.text = displayedOrder.total
    }
}
