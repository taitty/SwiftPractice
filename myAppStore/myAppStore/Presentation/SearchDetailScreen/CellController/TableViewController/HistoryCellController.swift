//
//  HistoryCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class HistoryCellController: GenericCellController<HistoryCell> {
    
    override func configureCellContent(_ cell: HistoryCell, data: searchDetailScreenDataModel?) {

    }
    
    override func getCellHeight() -> CGFloat {
        return 170.0
    }
    
}
