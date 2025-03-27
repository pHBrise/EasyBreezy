//
//  NetworkError.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 23/3/2568 BE.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unexpectedResponse
    case responseCode(HTTPCode)
    case decodingFailed(DecodingError)
    case unknown(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .unexpectedResponse:
            return "Unexpected response from the server"
        case let .responseCode(code):
            return "Unexpected response code: \(code)"
        case let .decodingFailed(decodingError):
            return "Decoding failed: \(decodingError)"
        case let .unknown(error):
            return "Unknown error: \(error)"
        }
    }
}
