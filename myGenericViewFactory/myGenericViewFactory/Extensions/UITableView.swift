//
//  UITableView.swift
//  myGenericViewFactory
//
//  Created by 김희수 on 2022/01/03.
//

import UIKit

extension UITableView: ReusableCellHolder {
    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        register(nib, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}
