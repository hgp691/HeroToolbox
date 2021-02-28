//
//  NetworkServiceTests.swift
//  HeroCommonsTests
//
//  Created by Horacio Guzman on 18/02/21.
//

import XCTest
@testable import HeroToolbox

enum TestError: Error {
    case test
}

extension TestError: LocalizedError {
    var errorDescription: String? {
        return "Test"
    }
}

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    var route: NetworkRouteProtocolMock!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkService = NetworkService(urlSession: MockURLProtocol.defaultURLSessionForMock())
        route = NetworkRouteProtocolMock()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkService = nil
        route = nil
    }

    func test_NetworkService_RouteThrowError() {
        // Given
        let error = TestError.test
        let expectedDescription = error.errorDescription
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        requestBuilder.errorForthrowing = error
        let expectation = XCTestExpectation(description: "Expectation for NetworkService")
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .failure(let networkError):
                let description = networkError.localizedDescription
                XCTAssertEqual(description, expectedDescription, "The errors must be the same")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NetworkService_RouteThrowNetworkError() {
        // Given
        let error = NetworkError.noDataNoResponse
        let expectedDescription = error.errorDescription
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        requestBuilder.errorForthrowing = error
        let expectation = XCTestExpectation(description: "Expectation for NetworkService")
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .failure(let networkError):
                let description = networkError.localizedDescription
                XCTAssertEqual(description, expectedDescription, "The errors must be the same")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NetworkService_ServerResponseError() {
        // Given
        let expectedDescription = "The operation couldn’t be completed. (HeroToolboxTests.TestError error 0.)"
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        let expectation = XCTestExpectation(description: "Expectation for NetworkService")
        MockURLProtocol.returnError()
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .failure(let networkError):
                let description = networkError.localizedDescription
                XCTAssertEqual(description, expectedDescription, "The errors must be the same")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NetworkService_ServerResponseNoData() {
        // Given
        let expectedDescription = NetworkError.noDataNoResponse.localizedDescription
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        let expectation = XCTestExpectation(description: "Expectation for NetworkService")
        MockURLProtocol.returnNoData()
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .failure(let networkError):
                let description = networkError.localizedDescription
                XCTAssertEqual(description, expectedDescription, "The errors must be the same")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NetworkService_ErrorCode600() {
        // Given
        let code = 600
        let data = "Hello world".data(using: .utf8)
        let expectedDescription = NetworkError.unhandledStatusCode(600, data!).localizedDescription
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        let expectation = XCTestExpectation(description: "Expectation for NetworkService")
        MockURLProtocol.returnErrorCode(code: code)
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .failure(let networkError):
                let description = networkError.localizedDescription
                XCTAssertEqual(description, expectedDescription, "The errors must be the same")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NetworkService_ErrorCode500() {
        // Given
        let code = 500
        let data = "Hello world".data(using: .utf8)
        let expectedDescription = NetworkError.serverError(code, data!).localizedDescription
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        let expectation = XCTestExpectation(description: "Expectation for NetworkService")
        MockURLProtocol.returnErrorCode(code: code)
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .failure(let networkError):
                let description = networkError.localizedDescription
                XCTAssertEqual(description, expectedDescription, "The errors must be the same")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NetworkService_ErrorCode400() {
        // Given
        let code = 400
        let data = "Hello world".data(using: .utf8)
        let expectedDescription = NetworkError.userError(code, data!).localizedDescription
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        let expectation = XCTestExpectation(description: "Expectation for NetworkService")
        MockURLProtocol.returnErrorCode(code: code)
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .failure(let networkError):
                let description = networkError.localizedDescription
                XCTAssertEqual(description, expectedDescription, "The errors must be the same")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NetworkService_ErrorDecoding() {
        // Given
        let expectedDescription = "The data couldn’t be read because it isn’t in the correct format."
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        let expectation = XCTestExpectation(description: "Expectation for NetworkService")
        MockURLProtocol.returnDecodingError()
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .failure(let networkError):
                let description = networkError.localizedDescription
                XCTAssertEqual(description, expectedDescription, "The errors must be the same")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NetworkService_Succed() {
        // Given
        let requestBuilder = NetworkRequestBuilderProtocolMock()
        let expectedDictionary = ["TestKey": "Test"]
        let expectation = XCTestExpectation(description: "Expectation for NetworkService")
        MockURLProtocol.returnSucced(with: expectedDictionary)
        // When
        networkService.sendRequest(requestBuilder) { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .success(let receivedDictionary):
                XCTAssertEqual(expectedDictionary["TestKey"],
                               receivedDictionary["TestKey"],
                               "The dictionaries must be the same")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
