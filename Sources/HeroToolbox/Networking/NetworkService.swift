//
//  File.swift
//  
//
//  Created by Horacio Guzman on 16/02/21.
//

import Foundation

public class NetworkService: NetworkServiceProtocol {
    
    let urlSession: URLSession
    var dataTask: URLSessionDataTask?
    
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func sendRequest<T: Decodable>(_ requesBuilder: NetworkRequestBuilderProtocol,
                                          completion: ((Result<T, NetworkError>) -> Void)?) {
        do {
            let request = try requesBuilder.buildRequest()
            dataTask = urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion?(.failure(NetworkError.error(error)))
                } else {
                    guard let data = data,
                          !data.isEmpty,
                          let response = response as? HTTPURLResponse else {
                        completion?(.failure(NetworkError.noDataNoResponse))
                        return
                    }
                    switch response.statusCode {
                        case 200 ... 299:
                            do {
                                let object = try JSONDecoder().decode(T.self, from: data)
                                completion?(.success(object))
                            } catch {
                                completion?(.failure(NetworkError.errorDecoding(error)))
                            }
                        case 400 ... 499:
                            completion?(.failure(NetworkError.userError(response.statusCode, data)))
                        case 500 ... 599:
                            completion?(.failure(NetworkError.serverError(response.statusCode, data)))
                        default:
                            completion?(.failure(NetworkError.unhandledStatusCode(response.statusCode, data)))
                    }
                }
            }
            dataTask?.resume()
        } catch let error as NetworkError {
            completion?(.failure(error))
        } catch {
            completion?(.failure(NetworkError.error(error)))
        }
    }
}
