//
//  MainViewController.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/27.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainViewProtocol: AnyObject {}

final class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScreen()
        presenter.onViewDidLoad()
    }

    private func setUpScreen() {
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let wireframe = MainWireframe()

        self.presenter = presenter
        presenter.view = self
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
    }
    
}

// MARK: - ViewProtocol
extension MainViewController: MainViewProtocol {}
