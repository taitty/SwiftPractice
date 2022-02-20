//
//  ContentTileFactory.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/15.
//

import Foundation
import UIKit

class ContentTileFactory {

    func registerCells(on: UICollectionView, type: ContentTileType) {
        switch type {
        case .Poster:
            guard let controller = try? DIContainer.resolve(ContentTileCellController.self) else {
                Log.Debug(.UI, "Cell Controller is not registered")
                return
            }
            
            controller.registerCell(on: on)
        }
    }
    
    func configurationCell(on: UICollectionView, type: ContentTileType, indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .Poster:
            guard let controller = try? DIContainer.resolve(ContentTileCellController.self) else {
                Log.Debug(.UI, "Cell Controller is not registered")
                return UICollectionViewCell()
            }
            
            return controller.configurationCell(on: on, indexPath: indexPath)
        }
    }
    
    func getHeight(type: ContentTileType) -> CGSize {
        switch type {
        case .Poster:
            guard let controller = try? DIContainer.resolve(ContentTileCellController.self) else {
                Log.Debug(.UI, "Cell Controller is not registered")
                return CGSize(width: 0.0, height: 0.0)
            }
            
            return controller.getHeight()
        }
    }
    
}
