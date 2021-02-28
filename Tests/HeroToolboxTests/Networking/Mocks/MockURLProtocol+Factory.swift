//
//  MockURLProtocol+Factory.swift
//  HeroCommonsTests
//
//  Created by Horacio Guzman on 18/02/21.
//

import Foundation
import HeroToolbox

extension MockURLProtocol {
    
    /// Return an Error to the client
    static func returnError() {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse()
            let error = TestError.test
            return (response, nil, error)
        }
    }
    
    /// Return an Error to the client
    static func returnNoData() {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse()
            return (response, nil, nil)
        }
    }
    
    /// Return an Error code
    static func returnErrorCode(code: Int) {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, Self.getBodyData(), nil)
        }
    }
    
    // Return a decode object string for cause an error of decoding
    static func returnDecodingError() {
        MockURLProtocol.requestHandler = { request in
            let data = "Hello World".data(using: .utf8)
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, data, nil)
        }
    }
    
    // Return a success object
    static func returnSucced(with dictionary: [String: String]) {
        MockURLProtocol.requestHandler = { request in
            let data = getBodyData(with: dictionary)
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, data, nil)
        }
    }
    
    // Throw an Error
    static func returnThrowError() {
        MockURLProtocol.requestHandler = { request in
            let error = TestError.test
            throw error
        }
    }
    
    fileprivate static func getBodyData(with dictionary: [String: String] = ["Test": "Test"]) -> Data? {
        return try? JSONEncoder().encode(dictionary)
    }
}
