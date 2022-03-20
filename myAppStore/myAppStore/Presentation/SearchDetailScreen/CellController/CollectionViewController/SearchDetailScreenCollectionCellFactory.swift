//
//  SearchDetailScreenCollectionCellFactory.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

enum SearchDetailScreenCollectionCell: String, CaseIterable {
    case previewListCell
    case infoListCell
    
    var controller: CellController<UICollectionView> {
        switch self {
        case .previewListCell:
            return PreviewListCellController()
        case .infoListCell:
            return InfoListCellController()
        }
    }
    
    var type: CellController<UICollectionView>.Type {
        switch self {
        case .previewListCell:
            return PreviewListCellController.self
        case .infoListCell:
            return InfoListCellController.self
        }
    }
}

class SearchDetailScreenCollectionCellFactory {
    
    func registerCells(collectionView: UICollectionView, data: [String]) -> [CellController<UICollectionView>] {
        data.compactMap { item in
            guard let cell = SearchDetailScreenCollectionCell(rawValue: item) else {
                Log.Debug(.UI, "\(item) is not supported cell...")
                return nil
            }
            cell.type.registerCell(on: collectionView)
            return cell.controller
        }
    }
    
}

