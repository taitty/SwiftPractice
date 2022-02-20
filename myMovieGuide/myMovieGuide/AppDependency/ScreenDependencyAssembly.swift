//
//  ScreenDependencyAssembly.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/01/26.
//

import Foundation
import Swinject

class ScreenDependencyAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(HomeScreenWireframe.self) { _ in HomeScreenWireframe() }
        container.register(DetailScreenWireframe.self) { _ in DetailScreenWireframe() }
    }
    
}
