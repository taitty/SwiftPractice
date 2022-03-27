//
//  GenericCellController.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2022/03/25.
//

import Foundation
import UIKit

class GenericCellController {
    
    class var cellClass: AnyClass {
        fatalError("Must be implemented by children")
    }
    
    static var cellIdentifier: String {
        return String(describing: cellClass)
    }
    
    func configurationCell(on: UITableView, data: CellData, indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func getHeightForCell() -> CGFloat {
        return 0.0
    }
}
