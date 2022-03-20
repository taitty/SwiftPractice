//
//  ImageCollectionCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class ImageCollectionCellController: GenericCellController<ImageCollectionCell> {
    
    override func configureCellContent(_ cell: ImageCollectionCell, data: searchDetailScreenDataModel?) {
        cell.imageCollection.delegate = cell
        cell.imageCollection.dataSource = cell
        cell.viewData = []
    }
    
    override func getCellHeight() -> CGFloat {
        return 250.0
    }
    
}
