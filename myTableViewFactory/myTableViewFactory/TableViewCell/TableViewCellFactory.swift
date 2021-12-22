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
    static func registerCell(on tableView: UITableView) -> UITableViewCell
    func getCellForTableView(_ tableView: UITableView, data: String) -> UITableViewCell
    func didCellSelected(_ tableView: UITableView, indexPath: IndexPath)
}

class TableViewCellFactory {
    
    let tableView: UITableView
    var tableViewCells: Array<UITableViewCell> = []
    
    init(tableView: UITableView) {
        self.tableView = tableView

        registerCells()
    }
    
    func registerCells() {
        tableViewCells.append(FirstTableViewCell.registerCell(on: tableView))
        tableViewCells.append(SecondTableViewCell.registerCell(on: tableView))
    }

    func getCellForTableView(cellType: TableViewCellType, data: String) -> UITableViewCell {
        switch cellType {
        case .FirstCellType:
            return FirstTableViewCell().getCellForTableView(tableView, data: data)
        case .SecondCellType:
            return SecondTableViewCell().getCellForTableView(tableView, data: data)
        }
    } 
    
}
