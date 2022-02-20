//
//  DetailScreenInteractor.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/28.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DetailScreenInteractorProtocol: AnyObject {}

final class DetailScreenInteractor {
    weak var presenter: DetailScreenPresenterProtocol!
}

extension DetailScreenInteractor: DetailScreenInteractorProtocol {}
