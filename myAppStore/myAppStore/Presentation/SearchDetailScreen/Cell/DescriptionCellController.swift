//
//  DescriptionCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class DescriptionCellController: GenericCellController<DescriptionCell> {
    
    override func configureCellContent(_ cell: DescriptionCell, data: searchDetailScreenDataModel?) {
        
    }
    
    override func getCellHeight() -> CGFloat {
        return 170.0
    }
    
}
