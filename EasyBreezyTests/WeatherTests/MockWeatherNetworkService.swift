//
//  MockWeatherNetworkService.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 27/3/2568 BE.
//

import XCTest
import Combine
@testable import EasyBreezy

// MARK: - Mock Objects

class MockWeatherNetworkService: WeatherNetworkServiceProtocol {
    var shouldSucceed = true
    var mockWeatherResponse: WeatherResponseModel?
    var mockError: Error?

    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponseModel, Error> {
        if shouldSucceed {
            if let response = mockWeatherResponse {
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NetworkError.unexpectedResponse)
                    .eraseToAnyPublisher()
            }
        } else {
            if let error = mockError {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NetworkError.unknown(NSError(domain: "Mock", code: 0, userInfo: nil))).eraseToAnyPublisher()
            }
        }
    }
}
