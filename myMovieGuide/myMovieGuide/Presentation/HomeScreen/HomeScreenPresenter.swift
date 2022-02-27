//
//  HomeScreenPresenter.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/26.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

protocol HomeScreenPresenterProtocol: AnyObject {
    func onViewDidLoad()
    func touchedCell(data: HomeScreenCategoryContent?)
}

final class HomeScreenPresenter {
    weak var view: HomeScreenViewProtocol!
    var wireframe: HomeScreenWireframeProtocol!
    var interactor: HomeScreenInteractorProtocol!

    private var disposables = CompositeDisposable()
    
    init() {}
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
}

// MARK: - PresenterProtocol

extension HomeScreenPresenter: HomeScreenPresenterProtocol {
    
    func onViewDidLoad() {
        interactor.requestHomeData() { data in
            self.view.updateScreen(data: data)
        }
    }
    
    func touchedCell(data: HomeScreenCategoryContent?) {
        interactor.prepareChangeToDetailScreen(data: data)
        wireframe.routeToDetailScreen(from: view as! UIViewController)
    }
}
