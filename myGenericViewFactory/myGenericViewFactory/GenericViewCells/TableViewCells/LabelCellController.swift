//
//  LabelCellController.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import Foundation
import UIKit

class LabelCellController: GenericCellController<LabelCell> {
    
    override func configureCellContent(_ cell: LabelCell, data: ViewDataModel) {
        cell.labelTitle.text = data.title
    }
    
    override func didSelectCell() {
        
    }
    
    override func getCellHeight() -> CGFloat {
        return 60.0
    }
}
