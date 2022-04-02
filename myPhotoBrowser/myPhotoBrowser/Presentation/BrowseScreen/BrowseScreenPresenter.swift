//
//  BrowseScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

protocol BrowseScreenPresenterProtocol {
    var dataChecker: Published<[PhotoInfo]>.Publisher { get }
    
    func cellSelected(index: Int)
    func onViewDidLoad()
}

final class BrowseScreenPresenter {
    
    var interactor: BrowseScreenInteractorProtocol?
    var wireframe: BrowseScreenWireframeProtocol?
    var cancellable = Set<AnyCancellable>()
    var dataChecker: Published<[PhotoInfo]>.Publisher { $data }
    @Published var data: [PhotoInfo] = []
    
    private func setObserver() {
        let dataObserver = interactor?.dataPublisher
        dataObserver?.sink { self.data = $0 }.store(in: &cancellable)
    }
    
}

extension BrowseScreenPresenter: BrowseScreenPresenterProtocol {
    
    func cellSelected(index: Int) {
        wireframe?.routeToDetailScreen(index: index, data: data)
    }
    
    func onViewDidLoad() {
        setObserver()
        interactor?.getHomeData()
    }
    
}