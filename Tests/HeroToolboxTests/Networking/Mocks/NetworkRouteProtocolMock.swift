//
//  NetworkRouteProtocolMock.swift
//  HeroCommonsTests
//
//  Created by Horacio Guzman on 18/02/21.
//

import Foundation
import HeroToolbox

class NetworkRouteProtocolMock: NetworkRouteProtocol {
   
    var domain: String = "https://test.com"
    var endpoint: String = "/test"
    var headers: [String : String]? = nil
    var body: Encodable? = nil
    var parameters: [String : String]? = nil
    var method: NetworkMethod = .get
}
