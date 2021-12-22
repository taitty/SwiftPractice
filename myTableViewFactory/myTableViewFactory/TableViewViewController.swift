//
//  ViewController.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/22.
//

import UIKit

class TableViewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dataManager = TableViewDataManager()
    let cellFactory = TableViewCellFactory()
    
    var viewData: [TableViewDataModel] = []
    var cellController: [TableViewCellProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewData = dataManager.getTableViewData()
        cellFactory.registerCells(tableView: tableView, data: viewData)
        cellController = cellFactory.getCellController(data: viewData)
    }


}

extension TableViewViewController: UITableViewDelegate {
    
}

extension TableViewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellController.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellController[indexPath.row].getCellForRow(tableView: tableView, data: viewData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellController[indexPath.row].getCellHeight()
    }
    
}

