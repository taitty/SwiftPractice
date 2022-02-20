//
//  DetailScreenViewController.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/28.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailScreenViewProtocol: AnyObject {}

final class DetailScreenViewController: UIViewController {
    var presenter: DetailScreenPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
    }
}

// MARK: - ViewProtocol
extension DetailScreenViewController: DetailScreenViewProtocol {}
