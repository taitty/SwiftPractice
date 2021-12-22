//
//  SubTableCell.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/22.
//

import UIKit

class SubTableCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    let cellFactory = TableViewCellFactory()
    
    var viewData: [TableViewDataModel] = []
    var cellController: [TableViewCellProtocol] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        cellFactory.registerCells(tableView: tableView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SubTableCell: TableViewCellProtocol {
    
    func registerCell(tableView: UITableView) {
        let nibName = UINib(nibName: "SubTableCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SubTableCell")
    }
    
    func getCellForRow(tableView: UITableView, data: TableViewDataModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubTableCell") as! SubTableCell
        cell.viewData = data.item
        cell.cellController = cellFactory.getCellController(data: cell.viewData)
        self.cellController = cell.cellController
        return cell
    }
    
    func didCellSelected() {
        
    }
    
    func getCellHeight() -> CGFloat {
        var height = 0.0
        cellController.forEach { cell in
            height += cell.getCellHeight()
        }
        return height
    }
    
}

extension SubTableCell: UITableViewDelegate {
    
}

extension SubTableCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellController.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController[indexPath.row].getCellForRow(tableView: tableView, data: viewData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellController[indexPath.row].getCellHeight()
    }

}
