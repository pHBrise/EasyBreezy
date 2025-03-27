//
//  WebSer.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 23/3/2568 BE.
//
import Foundation
import Combine

protocol NetworkService { }

extension NetworkService {
    
    func call<JSONValue>(_ endPoint: EndPoint, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<JSONValue, Error> where JSONValue: Decodable {
        do {
            let request = try endPoint.asURLRequest()
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    guard let code = (response as? HTTPURLResponse)?.statusCode else {
                        throw NetworkError.unexpectedResponse
                    }
                    guard HTTPCodeRange.success.contains(code) else {
                        throw NetworkError.responseCode(code)
                    }
                    return data
                }
                .decode(type: JSONValue.self, decoder: decoder)
                .mapError { error in
                    if let decodingError = error as? DecodingError {
                        return NetworkError.decodingFailed(decodingError)
                    } else {
                        return NetworkError.unknown(error)
                    }
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
    }
}
