//
//  CollectionCellController.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import Foundation
import UIKit

class CollectionCellController: GenericCellController<CollectionCell> {
    
    let cellFactory = CollectionCellControllerFactory()
    var subItems: [CellController<UICollectionView>] = []
    
    override func configureCellContent(_ cell: CollectionCell, data: ViewDataModel) {
        cell.collectionView.delegate = cell
        cell.collectionView.dataSource = cell
        
        cell.viewData = data.item
        cellFactory.registerCells(collectionView: cell.collectionView, data: cell.viewData)
        cell.cellController = cellFactory.getCellController(data: cell.viewData)
        subItems = cell.cellController
    }
    
    override func getCellHeight() -> CGFloat {
        return 80.0
    }
}
