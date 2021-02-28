//
//  MockURLProtocolTests.swift
//  HeroCommonsTests
//
//  Created by Horacio Guzman on 19/02/21.
//

import XCTest
@testable import HeroToolbox

class MockURLProtocolTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_MockURLProtocol_noHandler() {
        // Given
        let networkService = NetworkService(urlSession: MockURLProtocol.defaultURLSessionForMock())
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        // When
        MockURLProtocol.requestHandler = nil
        expectFatalError(expectedMessage: "Handler must be provided in order to make a test") {
            networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            }
        }
    }

    func test_MockURLProtocol_throwError() {
        // Given
        let networkService = NetworkService(urlSession: MockURLProtocol.defaultURLSessionForMock())
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        let expectedError = "The operation couldn’t be completed. (HeroToolboxTests.TestError error 0.)"
        let expectation = XCTestExpectation(description: "test")
        MockURLProtocol.returnThrowError()
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedError)
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
