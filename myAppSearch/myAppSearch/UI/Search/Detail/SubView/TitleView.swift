//
//  TitleView.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/21.
//

import UIKit

struct TitleViewRequirement {
    let appIcon: String
    let appTitle: String
    let subTitle: String
}

class TitleView: UIView {
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        let nibs = Bundle.main.loadNibNamed("TitleView", owner: self)
        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(customView)
        
        appIcon.layer.cornerRadius = 10
    }
    
    func configuration(data: TitleViewRequirement) {
        appIcon.getImage(urlString: data.appIcon)
        self.appTitle.text = data.appTitle
        self.subTitle.text = data.subTitle
    }
}
