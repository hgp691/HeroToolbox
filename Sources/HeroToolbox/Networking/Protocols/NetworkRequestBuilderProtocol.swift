//
//  File.swift
//  
//
//  Created by Horacio Guzman on 16/02/21.
//

import Foundation

public protocol NetworkRequestBuilderProtocol {
    
    /// The route for build
    var route: NetworkRouteProtocol { get }
    /// The builder of the Request
    func buildRequest() throws -> URLRequest
}
