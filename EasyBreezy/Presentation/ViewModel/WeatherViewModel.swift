//
//  WeatherViewModel.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 25/3/2568 BE.
//
import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    var cancellables: Set<AnyCancellable> = []
    var usecase: WeatherUseCaseProtocol

    @Published var weather: WeatherModel?
    @Published var error: Error?

    
    init( weatherUseCase: WeatherUseCaseProtocol) {
        self.usecase = weatherUseCase
    }
        
    func loadWeather(lat: Double, lon: Double) {
        usecase.execute(lat: lat, lon: lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weather in
                self?.weather = weather
            })
            .store(in: &cancellables)
    }
}
