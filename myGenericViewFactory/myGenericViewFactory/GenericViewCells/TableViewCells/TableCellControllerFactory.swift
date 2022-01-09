//
//  TableCellControllerFactory.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2021/12/30.
//

import Foundation
import UIKit

enum CellType: String, CaseIterable {
    case labelType
    case buttonType
    case tableType
    case collectionType
    case stackType
    
    var controller: CellController<UITableView> {
        switch self {
        case .labelType:
            return LabelCellController()
        case .buttonType:
            return ButtonCellController()
        case .tableType:
            return TableCellController()
        case .collectionType:
            return CollectionCellController()
        case .stackType:
            return StackCellController()
        }
    }
    
    var type: CellController<UITableView>.Type {
        switch self {
        case .labelType:
            return LabelCellController.self
        case .buttonType:
            return ButtonCellController.self
        case .tableType:
            return TableCellController.self
        case .collectionType:
            return CollectionCellController.self
        case .stackType:
            return StackCellController.self
        }
    }
}

class TableCellControllerFactory {
    
    func registerCells(tableView: UITableView, data: [ViewDataModel]) {
        data.forEach { item in
            CellType(rawValue: item.type)?.type.registerCell(on: tableView)
        }
    }
    
    func getCellController(data: [ViewDataModel]) -> [CellController<UITableView>] {
        return data.map { item in
            let cellController = CellType(rawValue: item.type)?.controller
            guard let cellController = cellController else {
                return LabelCellController()
            }
            return cellController
        }
    }
}
