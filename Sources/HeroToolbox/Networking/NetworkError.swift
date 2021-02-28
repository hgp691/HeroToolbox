//
//  File.swift
//  
//
//  Created by Horacio Guzman on 16/02/21.
//

import Foundation

public enum NetworkError: Error {
    /// The NetworkError handled an Error
    case error(Error)
    /// Something Happened with the data or response
    case noDataNoResponse
    /// Error Decoding response
    case errorDecoding(Error)
    /// User Error
    case userError(Int, Data)
    /// Server Error
    case serverError(Int, Data)
    /// Unhandled Status Code
    case unhandledStatusCode(Int, Data)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
            case .error(let error):
                return error.localizedDescription
            case .noDataNoResponse:
                return "There is not data or response"
            case .errorDecoding(let error):
                return error.localizedDescription
            case .userError(let code, _):
                return "something Happend (\(code))"
            case .serverError(let code, _):
                return "something Happend (\(code))"
            case .unhandledStatusCode(let code, _):
                return "something Happend (\(code))"
        }
    }
}
