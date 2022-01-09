//
//  CollectionCell.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/04.
//

import UIKit

class CollectionCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewData: [ViewDataModel] = []
    var cellController: [CellController<UICollectionView>] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CollectionCell: UICollectionViewDelegate {
    
}

extension CollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellController.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellController[indexPath.row].cellFromReusableCellHolder(collectionView, data: viewData[indexPath.row], forIndexPath: indexPath)
    }
    
}
