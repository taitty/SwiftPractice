# 증상
- caller 에서 호출한 getPopularList() 의 결과 Event 를, Caller 에서 받지 못함


# 원인
- callee 의 응답을 받기 전에, caller 가 deinit() 호출에 의해 해제됨
- caller 의 execute() 내부에는 self 에 대한 강한참조(strong reference)가 없음
  - 때문에, return 후 메모리에서 해제됨
- callee 의 경우, "status" 변수에 대한 강한참조가 존재함
  - 때문에, return 후에도 해제가 되지 않음
- "disposables" 의 경우,  ARC 가 증가하지 않음 (질문)
> 참조 :  https://babbab2.tistory.com/83

## Caller
```javascript
deinit {
    disposables.dispose()
    Log.Debug(.DOMAIN, "")
}

func execute(param: TmdbDataCategory) -> SignalProducer<TmdbContentData, TraceError> {
    return SignalProducer { observer, _ in        

        guard let dataSource = try? DIContainer.resolve(TmdbDataSourceProtocol.self) else {
            observer.send(error: TraceError(message: "TmdbDataSourceProtocol is not registered"))
            return
        }

        switch param {
        case .popular:
            self.disposables += dataSource.getPopularList().startWithResult { result in // "disposables" 에 대한 참조는 ARC 가 증가하지 않음
                switch result {
                case .success(let value):
                    observer.send(value: value)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: error)
                }
            }
        case .nowPlaying:
            dataSource.getNowPlayingList()
        case .upComing:
            dataSource.getUpcomingList()
        }
    }
}
```
## callee
```javascript
deinit {
    disposables.dispose()
    Log.Debug(.SERVER, "")
}

func getPopularList() -> SignalProducer<TmdbContentData, TraceError> {
    Log.Debug(.SERVER, "")
    return SignalProducer { observer, _ in

        self.disposables += self.status.producer // "status" 에 대한 강한참조
            .skip(while: { $0 != .connected })
            .startWithValues { _ in
                let data = TmdbContentData(title: "test", description: "test")
                observer.send(value: data)
                observer.sendCompleted()
            }
    }
}
```
    
# 개선안
- caller 에서도 callee 로부터 받은 Event 를 내부 변수에 업데이트하기 위한 강한 참조를 추가할 경우, 메모리 해제를 방지할 수 있음
- callee 의 응답이 caller 에 영향이 없는 경우에만 '[weak self]' 와 같이 사용
```javascript
private var updateStatus: Bool = false

deinit {
    disposables.dispose()
    Log.Debug(.DOMAIN, "")
}

func execute(param: TmdbDataCategory) -> SignalProducer<TmdbContentData, TraceError> {
    return SignalProducer { observer, _ in        

        guard let dataSource = try? DIContainer.resolve(TmdbDataSourceProtocol.self) else {
            observer.send(error: TraceError(message: "TmdbDataSourceProtocol is not registered"))
            return
        }

        switch param {
        case .popular:
            self.disposables += dataSource.getPopularList().startWithResult { result in
                switch result {
                case .success(let value):
                    observer.send(value: value)
                    observer.sendCompleted()
                    self.updateStatus = true // 메모리 해제 방지를 위한 참조 추가
                case .failure(let error):
                    observer.send(error: error)
                }
            }
        case .nowPlaying:
            dataSource.getNowPlayingList()
        case .upComing:
            dataSource.getUpcomingList()
        }
    }
}
```
