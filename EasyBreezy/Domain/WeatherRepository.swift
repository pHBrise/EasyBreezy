//
//  WeatherRepository.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 27/3/2568 BE.
//

import Foundation
import Combine

protocol WeatherRepositoryProtocol {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponseModel, Error>
}


class WeatherRepository: WeatherRepositoryProtocol {
    
    private let networkService: WeatherNetworkServiceProtocol

    init(networkService: WeatherNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponseModel, any Error> {
        return networkService.fetchWeather(lat: lat, lon: lon)
    }
    
}
