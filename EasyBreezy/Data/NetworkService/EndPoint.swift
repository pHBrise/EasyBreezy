//
//  EndPoint.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 23/3/2568 BE.
//

import Foundation

protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var params: [String: String] { get }
    func body() throws -> Data?
}

extension EndPoint {
    func asURLRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        var urlrequest = URLRequest(url: url)
        urlrequest.httpMethod = method.rawValue
        urlrequest.allHTTPHeaderFields = headers
        urlrequest.httpBody = try body()
        return urlrequest
    }
}
