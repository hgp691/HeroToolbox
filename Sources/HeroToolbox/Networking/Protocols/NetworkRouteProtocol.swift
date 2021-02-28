//
//  File.swift
//  
//
//  Created by Horacio Guzman on 16/02/21.
//

import Foundation

public protocol NetworkRouteProtocol {
    /// The Domain for the request
    var domain: String { get }
    /// The endpoint of the request
    var endpoint: String { get }
    /// The headers for the request
    var headers: [String: String]? { get }
    /// The body for the request
    var body: Encodable? { get }
    /// The parameters for the request
    var parameters: [String: String]? { get }
    /// The http method
    var method: NetworkMethod { get }
}
