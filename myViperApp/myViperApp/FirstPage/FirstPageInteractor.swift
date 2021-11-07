//
//  FirstPageInteractor.swift
//  myViperApp
//
//  Created by 김희수 on 2021/11/08.
//

import Foundation

protocol FirstPageInteractorProtocol: AnyObject {
    var presenter: FirstPagePresenterProtocol? { get set }
}

class FirstPageInteractor: FirstPageInteractorProtocol {
    weak var presenter: FirstPagePresenterProtocol?
    
}
