//
//  LabelCollectionCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class LabelCollectionCell: UITableViewCell {

    @IBOutlet weak var labelCollection: UICollectionView!
    
    var viewData: [String]?
    var layoutData: [String]?
    var cellController: [CellController<UICollectionView>]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension LabelCollectionCell: UICollectionViewDelegate {
    
}

extension LabelCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = viewData else {
            Log.Debug(.UI, "there is no data...")
            return 0
        }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellController = cellController, let data = viewData else {
            Log.Debug(.UI, "there is no data...")
            return UICollectionViewCell()
        }
        return cellController[indexPath.row].cellFromReusableCellHolder(collectionView, data: data[indexPath.row], forIndexPath: indexPath)
    }
    
}
