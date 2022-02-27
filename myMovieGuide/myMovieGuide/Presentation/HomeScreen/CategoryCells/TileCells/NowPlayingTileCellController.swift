//
//  NowPlayingTileCellController.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/16.
//

import UIKit

class NowPlayingTileCellController: ContentTileCellBase {   
    
    override var identifier: String {
        return String(describing: type(of: self)).components(separatedBy: "Controller").joined()
    }
        
    override func configurationCell(on: UICollectionView, data: HomeScreenCategoryContent, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = on.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! NowPlayingTileCell
        cell.titleLabel.text = data.title
        if let imageUrl = URL(string: data.image ?? ""), let data = try? Data(contentsOf: imageUrl) {
            cell.imageView.image = UIImage(data: data)
        }
        return cell
    }

}
