//
//  MockWeatherRepository.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 27/3/2568 BE.
//

import XCTest
import Combine
@testable import EasyBreezy

class MockWeatherRepository: WeatherRepositoryProtocol {
    var shouldSucceed = true
    var mockWeatherResponse: WeatherResponseModel?
    var mockError: Error?

    private let networkService: WeatherNetworkServiceProtocol

    init(networkService: WeatherNetworkServiceProtocol) {
        self.networkService = networkService
    }

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
