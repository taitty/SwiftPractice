//
//  StackButtonCell.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/05.
//

import Foundation
import UIKit

class StackButtonCell: UIView {
    
    @IBOutlet var stackButtonCell: UIView!
    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var cellLabel: UILabel!
        
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
        addSubview(stackButtonCell)
    }
    
}
