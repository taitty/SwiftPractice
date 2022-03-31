//
//  InfoScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

protocol InfoScreenPresenterProtocol {
    var dataChecker: Published<PhotoDetail>.Publisher { get }
    
    func onViewDidLoad()
}

final class InfoScreenPresenter {
    
    var interactor: InfoScreenInteractorProtocol?
    var wireframe: InfoScreenWireframeProtocol?
    var cancellable = Set<AnyCancellable>()
    var dataChecker: Published<PhotoDetail>.Publisher { $data }
    @Published var data = PhotoDetail()
    
    private func setObserver() {
        let dataObserver = interactor?.dataPublisher
        dataObserver?.sink {
            self.data = $0
            Log.Debug(.UI, "new data is updated")
        }.store(in: &cancellable)
    }
    
}

extension InfoScreenPresenter: InfoScreenPresenterProtocol {
    
    func onViewDidLoad() {
        setObserver()
        interactor?.getDetailData()
    }
    
}
