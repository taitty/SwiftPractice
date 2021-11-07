//
//  MainPageInteractor.swift
//  myViperApp
//
//  Created by 김희수 on 2021/11/05.
//

import Foundation

protocol MainPageInteractorProtocol {
    var presenter: MainPagePresenterProtocol? { get set }
}

class MainPageInteractor: MainPageInteractorProtocol {
    
    weak var presenter: MainPagePresenterProtocol?
 
}

