//
//  StackButtonCell.swift
//  socialPlatform
//
//  Created by 김희수 on 2022/01/11.
//

import UIKit

class StackButtonCell: UIView {

    @IBOutlet var stackButtonCell: UIView!
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellID: Int?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp() {
        Bundle.main.loadNibNamed("StackButtonCell", owner: self, options: nil)
        stackButtonCell.frame = self.bounds
        stackButtonCell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        stackButtonCell.addGestureRecognizer(tapGesture)
        addSubview(stackButtonCell)
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        print("tapped cell id : \(String(describing: cellID))")
    }
}
