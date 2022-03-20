//
//  LabelCollectionCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import Foundation
import UIKit

class LabelCollectionCellController: GenericCellController<LabelCollectionCell> {
    
    override func configureCellContent(_ cell: LabelCollectionCell, data: searchDetailScreenDataModel?) {
        cell.labelCollection.delegate = cell
        cell.labelCollection.dataSource = cell
        cell.viewData = []
    }
    
    override func getCellHeight() -> CGFloat {
        return 100.0
    }
}
