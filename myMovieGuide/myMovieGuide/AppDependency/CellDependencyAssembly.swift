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
        container.register(ContentTileCellController.self) { _ in ContentTileCellController() }
    }
    
}
