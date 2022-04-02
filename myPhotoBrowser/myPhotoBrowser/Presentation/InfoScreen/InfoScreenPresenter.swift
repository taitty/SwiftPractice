//
//  InfoScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

protocol InfoScreenPresenterProtocol {
    var dataObserver: Published<PhotoDetail>.Publisher { get }
    
    func onViewDidLoad()
    func pressCloseButton()
}

final class InfoScreenPresenter {
    
    var interactor: InfoScreenInteractorProtocol?
    var wireframe: InfoScreenWireframeProtocol?
    var dataObserver: Published<PhotoDetail>.Publisher { $data }
    @Published var data = PhotoDetail()
    
    private var cancellable = Set<AnyCancellable>()
    
    private func setObserver() {
        interactor?.dataPublisher.dropFirst().sink {
            self.data = $0
            Log.Debug(.UI, "new data is updated...")
        }.store(in: &cancellable)
    }
    
}

extension InfoScreenPresenter: InfoScreenPresenterProtocol {
    
    func onViewDidLoad() {
        setObserver()
        interactor?.getDetailData()
    }
    
    func pressCloseButton() {
        wireframe?.closeScreen()
    }
    
}
