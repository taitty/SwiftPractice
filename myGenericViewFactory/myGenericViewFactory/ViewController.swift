//
//  ViewController.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2021/12/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dataManager = ViewDataManager()
    var viewData: [ViewDataModel] = []
    
    let cellFactory = TableCellControllerFactory()
    var cellController: [CellController<UITableView>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewData = dataManager.getViewData()
        cellFactory.registerCells(tableView: tableView, data: viewData)
        cellController = cellFactory.getCellController(data: viewData)
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellController.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController[indexPath.row].cellFromReusableCellHolder(tableView, data: viewData[indexPath.row], forIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellController[indexPath.row].getCellHeight()
    }
    
}
