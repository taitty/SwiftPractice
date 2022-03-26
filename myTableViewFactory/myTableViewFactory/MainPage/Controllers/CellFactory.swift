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
    func registerCell(on: UITableView)
    func configurationCell(on: UITableView, data: CellData, indexPath: IndexPath) -> UITableViewCell?
}

class CellFactory: CellFactoryProtocol {
    
    func registerCell(on: UITableView) {
        CellType.allCases.forEach {
            let name = UINib(nibName: $0.cellID, bundle: nil)
            on.register(name, forCellReuseIdentifier: $0.cellID)
        }
    }
    
    func configurationCell(on: UITableView, data: CellData, indexPath: IndexPath) -> UITableViewCell? {
        let type = CellType(rawValue: data.type)
        return type?.controller.configurationCell(on: on, data: data, indexPath: indexPath)
    }
}
