//
//  SearchDetailScreenTableCellFactory.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

enum SearchDetailScreenTableCell: String, CaseIterable {
    case titleCell
    case labelCollectionCell
    case historyCell
    case imageCollectionCell
    case descriptionCell
    
    var controller: CellController<UITableView> {
        switch self {
        case .titleCell:
            return TitleCellController()
        case .labelCollectionCell:
            return LabelCollectionCellController()
        case .historyCell:
            return HistoryCellController()
        case .imageCollectionCell:
            return ImageCollectionCellController()
        case .descriptionCell:
            return DescriptionCellController()
        }
    }
    
    var type: CellController<UITableView>.Type {
        switch self {
        case .titleCell:
            return TitleCellController.self
        case .labelCollectionCell:
            return LabelCollectionCellController.self
        case .historyCell:
            return HistoryCellController.self
        case .imageCollectionCell:
            return ImageCollectionCellController.self
        case .descriptionCell:
            return DescriptionCellController.self
        }
    }
}

class SearchDetailScreenTableCellFactory {
    
    func registerCells(tableView: UITableView, data: [String]) -> [CellController<UITableView>] {
        data.compactMap { item in
            guard let cell = SearchDetailScreenTableCell(rawValue: item) else {
                Log.Debug(.UI, "\(item) is not supported cell...")
                return nil
            }
            cell.type.registerCell(on: tableView)
            return cell.controller
        }
    }
    
}
