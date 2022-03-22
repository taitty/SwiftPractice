//
//  LabelCollectionCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import Foundation
import UIKit

class LabelCollectionCellController: GenericCellController<LabelCollectionCell> {
    
    override func configureCellContent(_ cell: LabelCollectionCell, data: SearchModel?) {
        cell.viewData = data?.info
    }
    
    override func getCellHeight() -> CGFloat {
        return 100.0
    }
}
