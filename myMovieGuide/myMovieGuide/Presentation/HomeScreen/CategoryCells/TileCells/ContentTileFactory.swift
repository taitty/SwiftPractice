//
//  ContentTileFactory.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/15.
//

import Foundation
import UIKit

protocol ContentTileCellProtocol {
    func registerCell(on: UICollectionView)
    func configurationCell(on: UICollectionView, data: HomeScreenCategoryContent, indexPath: IndexPath) -> UICollectionViewCell
    func getHeight() -> CGSize
}

enum SectionContentCategory: Int {
    case popular
    case nowplaying
    case upcoming
    
    func getCategory() -> ContentTileCellProtocol? {
        do {
            switch self {
            case .popular:
                return try DIContainer.resolve(PopularTileCellController.self)
            case .nowplaying:
                return try DIContainer.resolve(NowPlayingTileCellController.self)
            case .upcoming:
                return try DIContainer.resolve(UpComingTileCellController.self)
            }
        } catch {
            Log.Debug(.UI, "cell controller is not registered")
            return nil
        }
    }
}

class ContentTileCellBase: ContentTileCellProtocol {
    
    var identifier: String {
        get {
            Log.Debug(.UI, "if need, it should be implemented")
            return ""
        }
    }
    
    func registerCell(on: UICollectionView) {
        let contentsNib = UINib(nibName: identifier, bundle: nil)
        on.register(contentsNib, forCellWithReuseIdentifier: identifier)
    }

    func configurationCell(on: UICollectionView, data: HomeScreenCategoryContent, indexPath: IndexPath) -> UICollectionViewCell {
        Log.Debug(.UI, "if need, it should be implemented")
        return UICollectionViewCell()
    }
    
    func getHeight() -> CGSize {
        return CGSize(width: 90.0, height: 160.0)
    }
    
}

class ContentTileFactory {

    func registerCells(on: UICollectionView, type: MovieGuideCategory) {
        guard let type = SectionContentCategory(rawValue: type.rawValue), let controller = type.getCategory() else {
            Log.Debug(.UI, "type[\(type)] is not valid")
            return
        }
        controller.registerCell(on: on)
    }
    
    func configurationCell(on: UICollectionView, type: MovieGuideCategory, data: HomeScreenCategoryContent, indexPath: IndexPath) -> UICollectionViewCell {
        guard let type = SectionContentCategory(rawValue: type.rawValue), let controller = type.getCategory() else {
            Log.Debug(.UI, "type[\(type)] is not valid")
            return UICollectionViewCell()
        }
        return controller.configurationCell(on: on, data: data, indexPath: indexPath)
    }
    
    func getHeight(type: MovieGuideCategory) -> CGSize {
        guard let type = SectionContentCategory(rawValue: type.rawValue), let controller = type.getCategory() else {
            Log.Debug(.UI, "type[\(type)] is not valid")
            return CGSize(width: 0.0, height: 0.0)
        }
        return controller.getHeight()
    }
    
}
