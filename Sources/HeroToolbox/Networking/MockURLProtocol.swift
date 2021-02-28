//
//  MockURLProtocol.swift
//  HeroCommons
//
//  Created by Horacio Guzman on 18/02/21.
//

import Foundation

public final class MockURLProtocol: URLProtocol {
    /// Closure that must be passed to the MockURLProtocol to mock every response when ever is needed
    public static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?, Error?))?
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        
        return request
    }
    
    public override func startLoading() {
        
        guard let handler = Self.requestHandler else {
            fatalError("Handler must be provided in order to make a test")
        }
        
        do {
            let (response, data, error) = try handler(request)
            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = data, !data.isEmpty {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
    }
    
    public override func stopLoading() {
        
    }
}

extension MockURLProtocol {
    
    public static func defaultURLSessionForMock() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        return urlSession
    }
}
