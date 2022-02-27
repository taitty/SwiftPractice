//
//  SectionContentsCell.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/15.
//

import UIKit
import ReactiveSwift

class SectionContentsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellFactory = ContentTileFactory()
    var sectionData: [HomeScreenCategoryContent] = []
    var type: MovieGuideCategory?
    
    private var eventHandler: HomeScreenCellDelegate? {
        guard let handler = try? DIContainer.resolve(HomeScreenCellDelegate.self) else {
            Log.Debug(.UI, "HomeScreenCellDelegate is not registered")
            return nil
        }
        return handler
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configuration()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configuration() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerCells()
    }
    
    private func registerCells() {
        MovieGuideCategory.allCases.forEach { type in
            cellFactory.registerCells(on: collectionView,type: type)
        }
    }
    
}

extension SectionContentsCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eventHandler?.selectedContentTileCell.value = (true, sectionData[indexPath.row])
    }
}

extension SectionContentsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let type = type else {
            Log.Debug(.UI, "\(String(describing: type)) is not valid")
            return UICollectionViewCell()
        }
        return cellFactory.configurationCell(on: collectionView, type: type, data: sectionData[indexPath.row], indexPath: indexPath)
    }
    
}

extension SectionContentsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let type = type else {
            Log.Debug(.UI, "\(String(describing: type)) is not valid")
            return CGSize(width: 0.0, height: 0.0)
        }
        return cellFactory.getHeight(type: type)
    }
    
}
