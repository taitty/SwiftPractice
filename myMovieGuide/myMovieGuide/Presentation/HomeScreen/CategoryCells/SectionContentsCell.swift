//
//  SectionContentsCell.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/15.
//

import UIKit

enum ContentTileType: Int, CaseIterable {
    case Poster
}

class SectionContentsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellFactory = ContentTileFactory()
    
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
        
        ContentTileType.allCases.forEach { item in
            cellFactory.registerCells(on: collectionView, type: item)
        }
    }
    
}

extension SectionContentsCell: UICollectionViewDelegate {
    
}

extension SectionContentsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = ContentTileType.Poster
        return cellFactory.configurationCell(on: collectionView, type: type, indexPath: indexPath)
    }
    
}

extension SectionContentsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let type = ContentTileType.Poster
        return cellFactory.getHeight(type: type)
    }
    
}
