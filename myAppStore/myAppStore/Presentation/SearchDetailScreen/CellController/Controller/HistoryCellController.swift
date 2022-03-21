//
//  HistoryCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class HistoryCellController: GenericCellController<HistoryCell> {
    
    override func configureCellContent(_ cell: HistoryCell, data: SearchModel?) {
//        cell.title.text = data?.appTitle
        cell.version.text = data?.version
        cell.updateTime.text = data?.updateDate
        cell.history.text = data?.history
    }
    
    override func getCellHeight() -> CGFloat {
        return 170.0
    }
    
}
