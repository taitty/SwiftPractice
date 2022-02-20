//
//  SectionCategoryFactory.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/15.
//

import Foundation
import UIKit

class SectionCategoryFactory {

    func registerCells(on: UITableView, type: HomeCategoryType) {
        switch type {
        case .Popular, .OnNow, .UpComing:
            guard let controller = try? DIContainer.resolve(SectionContentsCellController.self) else {
                Log.Debug(.UI, "Cell Controller is not registered")
                return
            }
            
            controller.registerCell(on: on)
        }
    }
    
    func configurationCell(on: UITableView, type: HomeCategoryType, indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .Popular, .OnNow, .UpComing:
            guard let controller = try? DIContainer.resolve(SectionContentsCellController.self) else {
                Log.Debug(.UI, "Cell Controller is not registered")
                return UITableViewCell()
            }
            
            return controller.configurationCell(on: on, indexPath: indexPath)
        }
    }
    
    func getHeight(type: HomeCategoryType) -> CGFloat {
        switch type {
        case .Popular, .OnNow, .UpComing:
            guard let controller = try? DIContainer.resolve(SectionContentsCellController.self) else {
                Log.Debug(.UI, "Cell Controller is not registered")
                return 0.0
            }
            
            return controller.getHeight()
        }
    }
    
}
