//
//  TitleCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class TitleCellController: GenericCellController<TitleCell> {
    
    override func configureCellContent(_ cell: TitleCell, data: searchDetailScreenDataModel?) {
        
    }
    
    override func getCellHeight() -> CGFloat {
        return 110.0
    }
}

