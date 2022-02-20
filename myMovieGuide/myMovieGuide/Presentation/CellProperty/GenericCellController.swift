//
//  GenericCellProtocol.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/15.
//

import Foundation
import UIKit

protocol GenericCellProtocol {
    
    associatedtype PARAM
    associatedtype VALUE
    associatedtype SIZE
    
    func registerCell(on: PARAM)
    func configurationCell(on: PARAM, indexPath: IndexPath) -> VALUE
    func getHeight() -> SIZE
    
}

class GenericCellController<PARAM, VALUE, SIZE>: GenericCellProtocol {
    
    var identifier: String? {
        Log.Debug(.UI, "need to be implemented")
        return nil
    }
    
    func registerCell(on: PARAM) {
        Log.Debug(.UI, "need to be implemented")
    }
    
    func configurationCell(on: PARAM, indexPath: IndexPath) -> VALUE {
        Log.Debug(.UI, "need to be implemented")
        return VALUE.self as! VALUE
    }
    
    func getHeight() -> SIZE {
        Log.Debug(.UI, "need to be implemented")
        return 0.0 as! SIZE
    }
    
}
