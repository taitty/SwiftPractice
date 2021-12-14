//
//  TableViewCellFactory.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/14.
//

import Foundation
import UIKit

enum TableViewCellType: Int, CaseIterable {
    case FirstCellType
    case SecondCellType
}

protocol CustomTableViewCellProtocol {
    func registerCell(on tableView: UITableView) -> CustomTableViewCellProtocol
    func getCellForTableView(_ tableView: UITableView) -> CustomTableViewCellProtocol
    func didCellSelected(_ tableView: UITableView, indexPath: IndexPath)
}

class TableViewCellFactory {
    
    let tableView: UITableView
    var tableViewCells: Array<CustomTableViewCellProtocol> = []
    
    init(tableView: UITableView) {
        self.tableView = tableView

        registerCells()
    }
    
    func registerCells() {
        tableViewCells.append(FirstTableViewCell().registerCell(on: tableView))
        tableViewCells.append(SecondTableViewCell().registerCell(on: tableView))
    }

    func getCellForTableView(cellType: TableViewCellType) -> CustomTableViewCellProtocol {
        switch cellType {
        case .FirstCellType:
            return FirstTableViewCell().getCellForTableView(tableView)
        case .SecondCellType:
            return SecondTableViewCell().getCellForTableView(tableView)
        }
    } 
    
}
