//
//  File.swift
//  
//
//  Created by Horacio Guzman on 16/02/21.
//

import Foundation

public protocol NetworkServiceProtocol {
    /// Function for Send Request
    func sendRequest<T: Decodable>(_ requesBuilder: NetworkRequestBuilderProtocol,
                                   completion: ((Result<T, NetworkError>) -> Void)?)
}
