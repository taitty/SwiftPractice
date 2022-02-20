//
//  AppDependency.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/01/26.
//

import Foundation
import Swinject

class DIContainer {
    
    static let share = DIContainer()
    
    private let assembler = Assembler()
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service! {
        return assembler.resolver.resolve(serviceType)
    }
    
    func apply(_ service: [Assembly]) {
        assembler.apply(assemblies: service)
    }
    
}

extension DIContainer {
    
    static func resolve<Service>(_ serviceType: Service.Type) throws -> Service {
        guard let service = DIContainer.share.resolve(serviceType) else {
            throw NSError(domain: "\(serviceType) is not registered", code: 0, userInfo: nil)
        }
        return service
    }
    
    static func apply(_ service: [Assembly]) {
        DIContainer.share.apply(service)
    }
    
}
