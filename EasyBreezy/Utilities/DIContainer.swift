//
//  DIContainer.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 27/3/2568 BE.
//

final class DIContainer {
    static let shared = DIContainer()
    
    private let netWorkService: WeatherNetworkServiceProtocol
    private let weatherRepository: WeatherRepositoryProtocol
    private let weatherUseCase: WeatherUseCaseProtocol
    
    private init() {
        self.netWorkService = WeatherNetworkService()
        self.weatherRepository = WeatherRepository(networkService: netWorkService)
        self.weatherUseCase = WeatherUseCase(weatherRepository: weatherRepository)
    }
    
    func makeWeatherViewModel() -> WeatherViewModel {
        return WeatherViewModel(weatherUseCase: weatherUseCase)
    }
}
