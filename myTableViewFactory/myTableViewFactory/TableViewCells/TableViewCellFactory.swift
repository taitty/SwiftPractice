//
//  TableViewCellFactory.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2021/12/22.
//

import Foundation
import UIKit

enum CellType: String, Codable, CaseIterable {
    case buttonType
    case labelType
    case subTableType
    
    var index: Int {
        switch self {
        case .buttonType:
            return 0
        case .labelType:
            return 1
        case .subTableType:
            return 0
        }
    }
    
    var controller: TableViewCellProtocol {
        switch self {
        case .buttonType:
            return ButtonCell()
        case .labelType:
            return LabelCell()
        case .subTableType:
            return SubTableCell()
        }
    }
}

protocol TableViewCellProtocol {
    func registerCell(tableView: UITableView)
    func getCellForRow(tableView: UITableView, data: TableViewDataModel) -> UITableViewCell
    func didCellSelected()
    func getCellHeight() -> CGFloat
}

class TableViewCellFactory {
    
    func registerCells(tableView: UITableView, data: [TableViewDataModel]) {
        CellType.allCases.forEach { item in
            item.controller.registerCell(tableView: tableView)
        }
    }
    
    func getCellController(data: [TableViewDataModel]) -> [TableViewCellProtocol] {
        return data.map { item in
            let cellController = CellType(rawValue: item.type)?.controller
            guard let cellController = cellController else {
                return LabelCell()
            }
            return cellController
        }
    }
}
