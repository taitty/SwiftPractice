//
//  LabelCellController.swift
//  myTableViewFactory
//
//  Created by 김희수 on 2022/03/26.
//

import Foundation
import UIKit

class LabelCellController: GenericCellController {
    
    override class var cellClass: AnyClass {
        return self
    }
    
    override func configurationCell(on: UITableView, data: CellData, indexPath: IndexPath) -> UITableViewCell {
        let cell = on.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LabelCell
        cell.firstLabel.text = data.firstString
        cell.secondLabel.text = data.secondString
        return cell
    }
    
    override func getHeightForCell() -> CGFloat {
        return 120.0
    }
    
}
