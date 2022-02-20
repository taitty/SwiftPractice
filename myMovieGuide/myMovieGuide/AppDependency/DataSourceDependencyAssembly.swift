//
//  DataSourceDependencyAssembly.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/02/08.
//

import Foundation
import Swinject

class DataSourceDependencyAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(TmdbDataSourceProtocol.self) { _ in TmdbDataSource() }
    }
    
}
