//
//  DetailScreenInteractor.swift
//  myMovieGuide
//
//  Created 김희수 on 2022/01/28.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import ReactiveSwift

protocol DetailScreenInteractorProtocol: AnyObject {
    func requestDetailData(completion: @escaping (DetailScreenContent) -> Void)
}

final class DetailScreenInteractor {
    weak var presenter: DetailScreenPresenterProtocol!
    
    private var detailData = try? DIContainer.resolve(DetailScreenContent.self)
    private var disposables = CompositeDisposable()
    
    deinit {
        disposables.dispose()
        Log.Debug(.UI, "")
    }
    
    private func convertData(from: MovieGuideContentData) -> DetailScreenContent {
        return DetailScreenContent(id: from.id,
                                   title: from.title,
                                   image: from.imgPath,
                                   director: from.director,
                                   player: from.actor,
                                   description: from.description,
                                   genres: from.genres?.joined(separator: ", "),
                                   etc: from.etc?.joined(separator: ", "))
    }
}

extension DetailScreenInteractor: DetailScreenInteractorProtocol {
    
    func requestDetailData(completion: @escaping (DetailScreenContent) -> Void) {
        guard let useCase = try? DIContainer.resolve(GetTmdbDetailDataUseCase.self) else {
            Log.Debug(.UI, "GetHomeDataUseCase is not registered")
            return
        }
        
        guard let id = detailData?.id else {
            Log.Debug(.UI, "content id is not valid")
            return
        }
        
        self.disposables += useCase.execute(String(id)).startWithResult { result in
            switch result {
            case .success(let value):
                completion(self.convertData(from: value))
            case .failure(let error):
                Log.Debug(.UI, error.message)
            }
        }
    }
    
}
