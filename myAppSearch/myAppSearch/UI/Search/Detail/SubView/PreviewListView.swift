//
//  PreviewListView.swift
//  myAppSearch
//
//  Created by 김희수 on 2023/03/21.
//

import UIKit

struct PreviewListViewRequirement {
    let imagePath: [String]
}

class PreviewListView: UIView {
    
    @IBOutlet weak var previewListView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        let nibs = Bundle.main.loadNibNamed("PreviewListView", owner: self)
        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(customView)
    }
    
    func configuration(data: PreviewListViewRequirement) {
        data.imagePath.forEach {
            let imageView = UIImageView()
            imageView.getImage(urlString: $0)
            imageView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            imageView.contentMode = .scaleAspectFit
            previewListView.addArrangedSubview(imageView)
        }
    }
}
