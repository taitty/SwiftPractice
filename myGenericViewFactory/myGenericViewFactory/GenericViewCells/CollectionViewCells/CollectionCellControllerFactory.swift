//
//  CollectionCellControllerFactory.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import Foundation
import UIKit

enum CollectionCellType: String, CaseIterable {
    case labelType
    case buttonType
    
    var controller: CellController<UICollectionView> {
        switch self {
        case .labelType:
            return CollectionLabelCellController()
        case .buttonType:
            return CollectionButtonCellController()
        }
    }
    
    var type: CellController<UICollectionView>.Type {
        switch self {
        case .labelType:
            return CollectionLabelCellController.self
        case .buttonType:
            return CollectionButtonCellController.self
        }
    }
}

class CollectionCellControllerFactory {
    
    func registerCells(collectionView: UICollectionView, data: [ViewDataModel]) {
        data.forEach { item in
            CollectionCellType(rawValue: item.type)?.type.registerCell(on: collectionView)
        }
    }
    
    func getCellController(data: [ViewDataModel]) -> [CellController<UICollectionView>] {
        return data.map { item in
            let cellController = CollectionCellType(rawValue: item.type)?.controller
            guard let cellController = cellController else {
                return CollectionLabelCellController()
            }
            return cellController
        }
    }
}
