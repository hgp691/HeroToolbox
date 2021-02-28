//
//  NetworkRequestBuilderProtocolMock.swift
//  HeroCommonsTests
//
//  Created by Horacio Guzman on 18/02/21.
//

import Foundation
import HeroToolbox

class NetworkRequestBuilderProtocolMock: NetworkRequestBuilderProtocol {
    
    let route: NetworkRouteProtocol
    
    var errorForthrowing: Error?
    var networkErrorForthrowing: NetworkError?
    
    init() {
        self.route = NetworkRouteProtocolMock()
    }
    
    func buildRequest() throws -> URLRequest {
        if errorForthrowing != nil {
            throw errorForthrowing!
        } else if networkErrorForthrowing != nil {
            throw networkErrorForthrowing!
        }
        
        return URLRequest(url: URL(string: "https://google.com")!)
    }
}
