//
//  myPhotoBrowserTests.swift
//  myPhotoBrowserTests
//
//  Created by 김희수 on 2022/03/30.
//

import XCTest
import Combine

@testable import myPhotoBrowser

class myPhotoBrowserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetHomeDataUseCaseFromMock() throws {
        let promise = expectation(description: "get HomeData from Mock")

        let useCase = GetHomeDataUseCase(dataSource: MockUnsplashDataSource())
        _ = useCase.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UI, "done to get homeData...")
            case .failure(let error):
                XCTFail(error.message)
            }
        }, receiveValue: { value in
            promise.fulfill()
            XCTAssertTrue(!value.isEmpty)
        })

        wait(for: [promise], timeout: 5)
    }

    func testGetDetailDataUseCaseFromMock() throws {
        let promise = expectation(description: "get DetailData from Mock")

        let useCase = GetDetailDataUseCase(dataSource: MockUnsplashDataSource())
        _ = useCase.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UI, "done to get detailData...")
            case .failure(let error):
                XCTFail(error.message)
            }
        }, receiveValue: { value in
            promise.fulfill()
        })

        wait(for: [promise], timeout: 5)
    }

    func testGetSearchDataUseCaseFromMock() throws {
        let promise = expectation(description: "get SearchData from Mock")
        
        let useCase = GetSearchDataUseCase(dataSource: MockUnsplashDataSource())
        _ = useCase.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UI, "done to get SearchData...")
            case .failure(let error):
                XCTFail(error.message)
            }
        }, receiveValue: { value in
            promise.fulfill()
            XCTAssertTrue(!value.isEmpty)
        })
        
        wait(for: [promise], timeout: 5)
    }
    
    func testGetHomeDataUseCaseFromReal() throws {
        let promise = expectation(description: "get HomeData from Real")
        var cancellable = Set<AnyCancellable>()
        
        let useCase = GetHomeDataUseCase(dataSource: UnsplashDataSource())
        useCase.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                Log.Debug(.UI, "done to get homeData...")
            case .failure(let error):
                XCTFail(error.message)
            }
        }, receiveValue: { value in
            promise.fulfill()
            XCTAssertTrue(!value.isEmpty)
        }).store(in: &cancellable)

        wait(for: [promise], timeout: 5)
    }
}
