//
//  DescriptionCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class DescriptionCellController: GenericCellController<DescriptionCell> {
    
    private var cellHeight = 170.0 {
        didSet {
            delegate.updateTable()
        }
    }
    private var prevValue = 0.0
    
    override func configureCellContent(_ cell: DescriptionCell, data: SearchModel?) {
        cell.summary.text = data?.guide
        cell.developer.text = data?.companyName
        cell.expandedHeight.signal.observeValues { value in
            if value == self.prevValue { return }
            self.prevValue = value
            self.cellHeight += value
        }
    }
    
    override func getCellHeight() -> CGFloat {
        return cellHeight
    }
    
}
