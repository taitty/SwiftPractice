//
//  NewFeatureView.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/21.
//

import UIKit

struct NewFeatureViewRequirement {
    let version: String
    let description: String
}

class NewFeatureView: UIView {
    
    @Published var needUpdate = false
    
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var heightAnchorView: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        let nibs = Bundle.main.loadNibNamed("NewFeatureView", owner: self)
        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(customView)
    }
    
    func configuration(data: NewFeatureViewRequirement) {
        version.text = data.version
        descriptionLabel.text = data.description
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.moreButton.isHidden = true
        self.heightAnchorView.isActive.toggle()
    }
}
