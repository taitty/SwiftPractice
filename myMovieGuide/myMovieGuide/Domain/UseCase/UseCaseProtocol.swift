//
//  UseCaseProtocol.swift
//  myMovieGuide
//
//  Created by 김희수 on 2022/01/28.
//

protocol UseCaseProtocol: AnyObject {
    associatedtype Param
    associatedtype ReturnType

    func execute(_ param: Param) -> ReturnType
}
