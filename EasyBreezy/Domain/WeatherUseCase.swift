//
//  WeatherUseCase.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 27/3/2568 BE.
//

import Combine
import Foundation

protocol WeatherUseCaseProtocol {
    func execute(lat: Double, lon: Double) -> AnyPublisher<WeatherModel, Error>
}

class WeatherUseCase: WeatherUseCaseProtocol {
    private let weatherRepository: WeatherRepositoryProtocol
    
    init(weatherRepository: WeatherRepositoryProtocol) {
        self.weatherRepository = weatherRepository
    }
    
    func execute(lat: Double, lon: Double) -> AnyPublisher<WeatherModel, Error> {
        return weatherRepository.fetchWeather(lat: lat, lon: lon)
            .map { response in
                WeatherModel(name: response.location.name,
                             isDay: response.current.isDay,
                             astrio: response.forecast.forecastday.first?.astro,
                             currentForecast: response.current,
                             hourlyForecast: [response.current] + response.forecast.forecastday.flatMap {
                                                                        $0.forecastHours.filter {
                                                                            if let timeEpoch = $0.timeEpoch {
                                                                                return TimeInterval(timeEpoch) > Date().timeIntervalSince1970 && TimeInterval(timeEpoch) < Date().timeIntervalSince1970 + 86400
                                                                            } else {
                                                                                return false
                                                                            }
                                                                        }
                                                                    },
                             dailyForecast: response.forecast.forecastday.compactMap{return WeatherModel.DailyForecast(dateEpoch: $0.dateEpoch, dailyForecast:$0.forecastDay)})
            }
            .eraseToAnyPublisher()
    }
}
