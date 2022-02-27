//
//  UseCaseDependencyAssembly.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/01/28.
//

import Foundation
import Swinject

class UseCaseDependencyAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(GetTmdbCategoryDataUseCase.self) { _ in GetTmdbCategoryDataUseCase() }
        container.register(GetTmdbDetailDataUseCase.self) { _ in GetTmdbDetailDataUseCase() }
    }
    
}
