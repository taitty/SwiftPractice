//
//  HomeScreenCellDelegate.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/22.
//

import Foundation
import ReactiveSwift

class HomeScreenCellDelegate {
    var selectedContentTileCell = MutableProperty<(Bool, HomeScreenCategoryContent?)>((false, nil))
}
