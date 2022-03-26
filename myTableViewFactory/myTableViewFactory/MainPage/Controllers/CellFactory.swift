//
//  CellFactory.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2022/03/25.
//

import Foundation
import UIKit

enum CellType: String, CaseIterable {
    case labelCell
    case imageCell
    
    var cellID: String {
        switch self {
        case .labelCell:
            return "LabelCell"
        case .imageCell:
            return "ImageCell"
        }
    }
    
    var controller: GenericCellController {
        switch self {
        case .labelCell:
            return LabelCellController()
        case .imageCell:
            return ImageCellController()
        }
    }
}

protocol CellFactoryProtocol {
    func registerCell(on: UITableView) -> [GenericCellController]
}

class CellFactory: CellFactoryProtocol {
    
    func registerCell(on: UITableView) -> [GenericCellController] {
        CellType.allCases.compactMap { cell in
            let name = UINib(nibName: cell.cellID, bundle: nil)
            on.register(name, forCellReuseIdentifier: cell.cellID)
            return cell.controller
        }
    }
    
}
