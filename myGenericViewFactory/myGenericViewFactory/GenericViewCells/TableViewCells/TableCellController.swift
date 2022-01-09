//
//  TableCellController.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import Foundation
import UIKit

class TableCellController: GenericCellController<TableCell> {
    
    let cellFactory = TableCellControllerFactory()
    var subItems: [CellController<UITableView>] = []
    
    override func configureCellContent(_ cell: TableCell, data: ViewDataModel) {
        cell.tableView.delegate = cell
        cell.tableView.dataSource = cell
        
        cell.viewData = data.item
        cellFactory.registerCells(tableView: cell.tableView, data: cell.viewData)
        cell.cellController = cellFactory.getCellController(data: cell.viewData)
        subItems = cell.cellController
    }
    
    override func getCellHeight() -> CGFloat {
        var height = 0.0
        subItems.forEach { item in
            height += item.getCellHeight()
        }
        return height
    }
    
}
