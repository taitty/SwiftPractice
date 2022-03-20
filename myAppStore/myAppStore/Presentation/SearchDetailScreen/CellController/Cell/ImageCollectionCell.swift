//
//  ImageCollectionCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class ImageCollectionCell: UITableViewCell {

    @IBOutlet weak var imageCollection: UICollectionView!
    
    var viewData: [SearchModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "PreviewListCell", bundle: nil)
        imageCollection.register(nib, forCellWithReuseIdentifier: "PreviewListCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ImageCollectionCell: UICollectionViewDelegate {
    
}

extension ImageCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = viewData else {
            Log.Debug(.UI, "there is no data...")
            return 0
        }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewListCell", for: indexPath) as? PreviewListCell else {
            Log.Debug(.UI, "Cell is not registered...")
            return UICollectionViewCell()
        }
        if let data = viewData,
           let imgUrl = URL(string: data[indexPath.row].previewImage?[indexPath.row] ?? ""),
           let data = try? Data(contentsOf: imgUrl) {
            cell.previewImage.image = UIImage(data: data)
        }
        return cell
    }
    
}
