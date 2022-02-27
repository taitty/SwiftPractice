//
//  CellDependencyAssembly.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/15.
//

import Foundation
import Swinject

class CellDependencyAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SectionContentsCellController.self) { _ in SectionContentsCellController() }
        container.register(PopularTileCellController.self) { _ in PopularTileCellController() }
        container.register(NowPlayingTileCellController.self) { _ in NowPlayingTileCellController() }
        container.register(UpComingTileCellController.self) { _ in UpComingTileCellController() }
        container.register(HomeScreenCellDelegate.self) { _ in HomeScreenCellDelegate() }.inObjectScope(.container)
        container.register(DetailScreenContent.self) { _ in DetailScreenContent() }.inObjectScope(.container)
    }
    
}
