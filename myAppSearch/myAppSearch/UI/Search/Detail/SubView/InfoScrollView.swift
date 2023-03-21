//
//  InfoScrollView.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/21.
//

import UIKit
import Cosmos

struct InfoScrollViewRequirement {
    let infoData: [AppDescription]
}

class InfoScrollView: UIView {
    enum InfoType: String {
        case rating
        case age
        case chart
        case dev
        case lang
    }

    @IBOutlet weak var ratingTitle: UILabel!
    @IBOutlet weak var ratingValue: UILabel!
    @IBOutlet weak var ratingStar: CosmosView!
    
    @IBOutlet weak var ageTitle: UILabel!
    @IBOutlet weak var ageValue: UILabel!
    @IBOutlet weak var ageUnit: UILabel!
    
    @IBOutlet weak var chartTitle: UILabel!
    @IBOutlet weak var chartLevel: UILabel!
    @IBOutlet weak var chartCategory: UILabel!
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryRegion: UILabel!
    
    @IBOutlet weak var vendorTitle: UILabel!
    @IBOutlet weak var vendorName: UILabel!
    
    @IBOutlet weak var langTitle: UILabel!
    @IBOutlet weak var langMark: UILabel!
    @IBOutlet weak var langKor: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        let nibs = Bundle.main.loadNibNamed("InfoScrollView", owner: self)
        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(customView)
    }
    
    func configuration(data: InfoScrollViewRequirement) {
        data.infoData.forEach {
            switch InfoType(rawValue: $0.type) {
            case .rating:
                ratingTitle.text = $0.top
                ratingValue.text = $0.middle
                ratingStar.rating = $0.rating
            case .age:
                ageTitle.text = $0.top
                ageValue.text = $0.middle
                ageUnit.text = $0.bottom
            case .chart:
                chartTitle.text = $0.top
                chartLevel.text = $0.middle
                chartCategory.text = $0.bottom
            case .dev:
                vendorTitle.text = $0.top
                vendorName.text = $0.bottom
            case .lang:
                langTitle.text = $0.top
                langMark.text = $0.middle
                langKor.text = $0.bottom
            default:
                Log.Debug(.UI, "not supported type : \($0.type)")
            }
        }
    }

}
