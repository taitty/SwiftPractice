//
//  ImageCollectionCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class ImageCollectionCellController: GenericCellController<ImageCollectionCell> {
    
    override func configureCellContent(_ cell: ImageCollectionCell, data: searchDetailScreenDataModel?) {
        
    }
    
    override func getCellHeight() -> CGFloat {
        return 250.0
    }
    
}
