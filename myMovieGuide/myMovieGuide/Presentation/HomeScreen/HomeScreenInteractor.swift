//
//  HomeScreenInteractor.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/26.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import ReactiveSwift

protocol HomeScreenInteractorProtocol: AnyObject {
    func requestHomeData()
}

final class HomeScreenInteractor {
    
    weak var presenter: HomeScreenPresenterProtocol!
    private var disposables = CompositeDisposable()
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
}

extension HomeScreenInteractor: HomeScreenInteractorProtocol {
    
    func requestHomeData() {
        guard let useCase = try? DIContainer.resolve(GetTmdbDataUseCase.self) else {
            Log.Debug(.UI, "GetHomeDataUseCase is not registered")
            return
        }

        self.disposables += useCase.execute(.contentList).startWithResult { result in
            switch result {
            case .success(let value):
                Log.Debug(.UI, "\(value)")
                Log.Debug(.UI, "\(value.count)")
                Log.Debug(.UI, "\(String(describing: value[value.count-1].category))")
                Log.Debug(.UI, "\(String(describing: value[value.count-1].data.count))")
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }
    }
}
