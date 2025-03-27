//
//  WeatherNetworkService.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 24/3/2568 BE.
//

import Foundation
import Combine

protocol WeatherNetworkServiceProtocol: NetworkService {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponseModel, Error>
}

struct WeatherNetworkService: WeatherNetworkServiceProtocol {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponseModel, any Error> {
        return call(WeatherEndPoint.weather(lat: lat, lon: lon))
    }

}

extension WeatherNetworkService {
    enum WeatherEndPoint {
        case weather(lat: Double, lon: Double)
    }
}

extension WeatherNetworkService.WeatherEndPoint: EndPoint {

    var baseURL: String {
        return "https://api.weatherapi.com/v1/"
    }
    
    var path: String {
        switch self {
            case .weather:
            return "forecast.json"
        }

    }
    
    var method: HTTPMethod {
        switch self {
            case .weather:
            return .get
        }
    }
    
    var headers: [String : String] {
        return ["Accept": "application/json"]
    }
    
    var params: [String : String] {
        switch self {
        case .weather(lat: let lat, lon: let lon):
            return ["key": "6c4a3ad7ef15474c8e9160743252203",
                    "q": "\(lat),\(lon)",
                    "days": "3",
                    "aqi": "yes"]
        }
    }
    
    func body() throws -> Data? {
        return nil
    }
    
}
