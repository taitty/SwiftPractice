//
//  CellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import Foundation
import UIKit

let DEFAULT_CELL_HEIGHT = 50.0

protocol ReusableCell: AnyObject {
    associatedtype CellHolder: ReusableCellHolder
}

protocol ReusableCellHolder: AnyObject {
    associatedtype CellType: ReusableCell where CellType.CellHolder == Self

    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String)
    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> CellType
}

protocol CellControllerProtocol {

    associatedtype CollectionType: ReusableCellHolder

    static func registerCell(on reusableCellHolder: CollectionType)
    func cellFromReusableCellHolder(_ reusableCellHolder: CollectionType, data: SearchModel?, forIndexPath indexPath: IndexPath) -> CollectionType.CellType
    func didSelectCell()
    func getCellHeight() -> CGFloat
}

protocol SearchDetailScreenDelegate {
    func updateTable()
}

class CellController<T: ReusableCellHolder>: CellControllerProtocol {

    var delegate: SearchDetailScreenDelegate!
    
    class var cellClass: AnyClass {
        fatalError("Must be implemented by children")
    }

    static var cellIdentifier: String {
        return String(describing: cellClass)
    }

    static func registerCell(on reusableCellHolder: T) {
        let bundle = Bundle(for: cellClass)
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }

    final func cellFromReusableCellHolder(_ reusableCellHolder: T, data: SearchModel?, forIndexPath indexPath: IndexPath) -> T.CellType {
        let cell = reusableCellHolder.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath)
        configureCell(cell, data: data)
        return cell
    }

    func configureCell(_ cell: T.CellType, data: SearchModel?) {
        // To be defined by children. By default do nothing.
    }
    
    func didSelectCell() {
        // To be defined by children. By default do nothing.
    }
    
    func getCellHeight() -> CGFloat {
        return DEFAULT_CELL_HEIGHT
    }
    
}
