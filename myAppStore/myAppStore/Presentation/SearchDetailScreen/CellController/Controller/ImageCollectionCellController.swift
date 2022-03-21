//
//  ImageCollectionCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class ImageCollectionCellController: GenericCellController<ImageCollectionCell> {
    
    override func configureCellContent(_ cell: ImageCollectionCell, data: SearchModel?) {
        cell.viewData = data?.previewImage
    }
    
    override func getCellHeight() -> CGFloat {
        return 200.0
    }
    
}
