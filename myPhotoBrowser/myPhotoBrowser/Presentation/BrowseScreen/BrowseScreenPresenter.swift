//
//  BrowseScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation
import Combine

protocol BrowseScreenPresenterProtocol {
    var dataObserver: Published<[PhotoInfo]>.Publisher { get }
    var screenModeObserver: Published<ScreenMode>.Publisher { get }
    
    func itemSelected()
    func onViewDidLoad()
    func requestSearch(keyword: String)
    func searchCanceled()
    func reachedLastItem()
}

final class BrowseScreenPresenter {
    
    var interactor: BrowseScreenInteractorProtocol?
    var wireframe: BrowseScreenWireframeProtocol?
    var cancellable = Set<AnyCancellable>()
    var dataObserver: Published<[PhotoInfo]>.Publisher { $data }
    var screenModeObserver: Published<ScreenMode>.Publisher { $screenMode }
    
    @Published var data: [PhotoInfo] = []
    @Published var screenMode: ScreenMode = .browse
    
    private func setObserver() {
        interactor?.dataPublisher.dropFirst().sink {
            self.data = $0
        }.store(in: &cancellable)
    }
    
}

extension BrowseScreenPresenter: BrowseScreenPresenterProtocol {
    
    func itemSelected() {
        wireframe?.routeToDetailScreen()
    }
    
    func onViewDidLoad() {
        setObserver()
        interactor?.getHomeData(mode: .initialData)
    }
    
    func requestSearch(keyword: String) {
        screenMode = .search
        interactor?.requestSearch(keyword: keyword, mode: .initialData)
    }
    
    func searchCanceled() {
        screenMode = .browse
        interactor?.getHomeData(mode: .initialData)
    }
    
    func reachedLastItem() {
        interactor?.requestMoreData(screenMode: screenMode, dataMode: .continueData)
    }
    
}
