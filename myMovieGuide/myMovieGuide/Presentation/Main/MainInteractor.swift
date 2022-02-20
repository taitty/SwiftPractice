//
//  MainInteractor.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/27.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func configuration()
}

final class MainInteractor {
    
    weak var presenter: MainPresenterProtocol!
    
    private func applyDependency() {
        DIContainer.apply([
            BasicDependencyAssembly(),
            ScreenDependencyAssembly(),
            UseCaseDependencyAssembly(),
            DataSourceDependencyAssembly(),
            CellDependencyAssembly()
        ])
    }
    
}

extension MainInteractor: MainInteractorProtocol {
    
    func configuration() {
        applyDependency()
    }
    
}
