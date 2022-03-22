//
//  LabelCollectionCell.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class LabelCollectionCell: UITableViewCell {

    @IBOutlet weak var labelCollection: UICollectionView!
    
    var viewData: [AppInfo]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelCollection.delegate = self
        labelCollection.dataSource = self
        
        let nib = UINib(nibName: "InfoListCell", bundle: nil)
        labelCollection.register(nib, forCellWithReuseIdentifier: "InfoListCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoListCell", for: indexPath) as? InfoListCell else {
            Log.Debug(.UI, "Cell is not registered...")
            return UICollectionViewCell()
        }
        if let data = viewData {
            cell.topLabel.text = data[indexPath.row].text_1st
            cell.middleLabel.text = data[indexPath.row].text_2nd
            cell.bottomLabel.text = data[indexPath.row].text_3rd
            cell.starRating.rating = data[indexPath.row].rating ?? 0
            
            switch data[indexPath.row].type {
            case "rating":
                cell.topLabel.isHidden = false
                cell.middleLabel.isHidden = false
                cell.bottomLabel.isHidden = true
                cell.starRating.isHidden = false
                cell.iconImage.isHidden = true
            case "age":
                cell.topLabel.isHidden = false
                cell.middleLabel.isHidden = false
                cell.bottomLabel.isHidden = false
                cell.starRating.isHidden = true
                cell.iconImage.isHidden = true
            case "chart":
                cell.topLabel.isHidden = false
                cell.middleLabel.isHidden = false
                cell.bottomLabel.isHidden = false
                cell.starRating.isHidden = true
                cell.iconImage.isHidden = true
            case "dev":
                cell.topLabel.isHidden = false
                cell.middleLabel.isHidden = true
                cell.bottomLabel.isHidden = false
                cell.starRating.isHidden = true
                cell.iconImage.isHidden = false
            case "lang":
                cell.topLabel.isHidden = false
                cell.middleLabel.isHidden = false
                cell.bottomLabel.isHidden = false
                cell.starRating.isHidden = true
                cell.iconImage.isHidden = true
            default:
                cell.topLabel.isHidden = true
                cell.middleLabel.isHidden = true
                cell.bottomLabel.isHidden = true
                cell.starRating.isHidden = true
                cell.iconImage.isHidden = true
            }
        }
        return cell
    }
    
}
