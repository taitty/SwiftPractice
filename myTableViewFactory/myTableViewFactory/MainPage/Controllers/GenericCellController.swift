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
    
    func getCell(tableView: UITableView, data: CellData, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier, for: indexPath)
        return cell
    }
}
