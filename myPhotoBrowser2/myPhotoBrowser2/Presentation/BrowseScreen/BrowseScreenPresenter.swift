//
//  BrowseScreenPresenter.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Combine

class BrowseScreenPresenter {
    
    private let interactor: BrowseScreenInteractor
    private let wireframe: BrowseScreenWireframe
    private var cancellable = Set<AnyCancellable>()

    @Published var data: [PhotoInfo] = []
    @Published var screenMode: ScreenMode = .browse
    
    init(interactor: BrowseScreenInteractor, wireframe: BrowseScreenWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func onViewDidLoad() {
        setObserver()
        interactor.getHomeData(page: 1)
    }
    
    private func setObserver() {
        interactor.$viewData
            .assign(to: \.data, on: self)
            .store(in: &cancellable)
    }
    
    func itemSelected(selected: Int) {
        wireframe.routeToDetailScreen(data: data, position: selected)
    }
    
    func requestSearch(keyword: String) {
        screenMode = .search
        interactor.requestSearch(keyword: keyword, page: 1)
    }
    
    func searchCanceled() {
        screenMode = .browse
        interactor.getHomeData(page: 1)
    }
    
    func reachedLastItem() {
        interactor.requestMoreData(screenMode: screenMode, page: 1)
    }
}
