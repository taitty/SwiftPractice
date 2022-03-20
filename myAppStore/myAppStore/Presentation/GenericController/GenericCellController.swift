//
//  GenericCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import Foundation
import UIKit

class GenericCellController<T: ReusableCell>: CellController<T.CellHolder> {

    typealias BaseReusableCell = T.CellHolder.CellType
    
    final override class var cellClass: AnyClass {
        return T.self
    }

    final override func configureCell(_ cell: BaseReusableCell, data: searchDetailScreenDataModel?) {
        let cell = cell as! T
        configureCellContent(cell, data: data)
    }

    func configureCellContent(_ cell: T, data: searchDetailScreenDataModel?) {
        // By default do nothing.
    }

}
