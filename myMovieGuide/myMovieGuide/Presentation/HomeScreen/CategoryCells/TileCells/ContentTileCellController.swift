//
//  ContentTileCellController.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/16.
//

import UIKit

class ContentTileCellController: GenericCellController<UICollectionView, UICollectionViewCell, CGSize> {
    
    override var identifier: String {
        return String(describing: type(of: self)).components(separatedBy: "Controller").joined()
    }
    
    override func registerCell(on: PARAM) {
        let contentsNib = UINib(nibName: identifier, bundle: nil)
        on.register(contentsNib, forCellWithReuseIdentifier: identifier)
    }
    
    override func configurationCell(on: PARAM, indexPath: IndexPath) -> VALUE {
        let cell = on.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        //TODO: need to implement cell configuration
        return cell
    }
    
    override func getHeight() -> SIZE {
        return CGSize(width: 90.0, height: 160.0)
    }
    
}
