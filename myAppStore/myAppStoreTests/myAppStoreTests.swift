//
//  myAppStoreTests.swift
//  myAppStoreTests
//
//  Created by 김희수 on 2022/03/19.
//

import ReactiveSwift
import XCTest
@testable import myAppStore

class myAppStoreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchUseCaseWithMock() throws {
        let promise = expectation(description: "get mock data rightly")
        
        let useCase = RequestSearchUseCase(dataSource: MockAppStoreDataSource())
        useCase.execute(keyword: "카카오").startWithResult { result in
            promise.fulfill()
            switch result {
            case .success(let data):
                XCTAssert(!data.isEmpty, "data is empty")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testSearchUseCaseEmptyResultWithReal() throws {
        let promise = expectation(description: "get empty data")
        
        let useCase = RequestSearchUseCase(dataSource: AppStoreDataSource())
        useCase.execute(keyword: "asdfasdfasdfa").startWithResult { result in
            promise.fulfill()
            switch result {
            case .success(let data):
                XCTAssert(data.isEmpty, "data is not empty")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testSearchUseCaseGetResultWithReal() throws {
        let promise = expectation(description: "get data rightly")
        
        let useCase = RequestSearchUseCase(dataSource: AppStoreDataSource())
        useCase.execute(keyword: "카카오").startWithResult { result in
            promise.fulfill()
            switch result {
            case .success(let data):
                XCTAssert(!data.isEmpty, "data is empty")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
