//
//  SectionCategoryFactory.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/15.
//

import Foundation
import UIKit

class SectionCategoryFactory {

    func registerCells(on: UITableView, type: MovieGuideCategory) {
        switch type {
        case .popular, .nowplaying, .upcoming:
            guard let controller = try? DIContainer.resolve(SectionContentsCellController.self) else {
                Log.Debug(.UI, "Cell Controller is not registered")
                return
            }
            controller.registerCell(on: on)
        }
    }
    
    func configurationCell(on: UITableView, viewData: HomeScreenCategory, indexPath: IndexPath) -> UITableViewCell {
        switch viewData.type {
        case .popular, .nowplaying, .upcoming:
            guard let controller = try? DIContainer.resolve(SectionContentsCellController.self) else {
                Log.Debug(.UI, "Cell Controller is not registered")
                return UITableViewCell()
            }
            return controller.configurationCell(on: on, data: viewData)
        default:
            Log.Debug(.UI, "\(String(describing: viewData.type)) is not valid")
            return UITableViewCell()
        }
    }
    
    func getHeight(type: MovieGuideCategory) -> CGFloat {
        switch type {
        case .popular, .nowplaying, .upcoming:
            guard let controller = try? DIContainer.resolve(SectionContentsCellController.self) else {
                Log.Debug(.UI, "Cell Controller is not registered")
                return 0.0
            }
            return controller.getHeight()
        }
    }
    
}
