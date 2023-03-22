//
//  myAppSearchTests.swift
//  myAppSearchTests
//
//  Created by 김희수 on 2023/03/19.
//

import XCTest
import Combine
@testable import myAppSearch

final class myAppSearchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestSearchUsecaseFailCaseWithMock() throws {
        let promise = expectation(description: "test fail case with mock")
        var cancellable = Set<AnyCancellable>()
        
        let useCase = RequestSearchUsecase(dataSource: AppContext.test.dataSource)
        useCase.execute(keyword: "오류").sink(receiveCompletion: { result in
            switch result {
            case .finished:
                XCTAssert(false, "success")
            case .failure(let error):
                promise.fulfill()
                XCTAssert(true, "\(error)")
            }
        }, receiveValue: { data in
            XCTAssert(data.isEmpty)
        })
        .store(in: &cancellable)
        
        wait(for: [promise], timeout: 5)
    }
    
    func testRequestSearchUsecasePassCaseWithMock() throws {
        let promise = expectation(description: "test pass case with mock")
        var cancellable = Set<AnyCancellable>()
        
        let useCase = RequestSearchUsecase(dataSource: AppContext.test.dataSource)
        useCase.execute(keyword: "카카오").sink(receiveCompletion: { result in
            switch result {
            case .finished:
                promise.fulfill()
                XCTAssert(true, "success")
            case .failure(let error):
                XCTAssert(false, "\(error)")
            }
        }, receiveValue: { data in
            XCTAssert(!data.isEmpty)
        })
        .store(in: &cancellable)
        
        wait(for: [promise], timeout: 5)
    }
    
    func testRequestSearchUsecasePassCaseWithReal() throws {
        let promise = expectation(description: "test real case")
        var cancellable = Set<AnyCancellable>()
        
        let useCase = RequestSearchUsecase(dataSource: AppContext.test.dataSource)
        useCase.execute(keyword: "카카오뱅크").sink(receiveCompletion: { result in
            switch result {
            case .finished:
                promise.fulfill()
                XCTAssert(true, "success")
            case .failure(let error):
                XCTAssert(false, "\(error)")
            }
        }, receiveValue: { data in
            XCTAssert(!data.isEmpty)
        })
        .store(in: &cancellable)
        
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
