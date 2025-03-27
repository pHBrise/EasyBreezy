//
//  ContentView.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 23/3/2568 BE.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @Environment(\.appBackgroundColor) var backgroundColor
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel: WeatherViewModel
    @State private var previousLocation: CLLocation?
    
    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let weather = viewModel.weather {
                    Text(weather.name)
                        .font(.system(size: 48, weight: .regular, design: .default))
                        .padding()
                    CurrentForecastView(currentWeather: weather.currentForecast, astro: weather.astrio, isDay: weather.isDay)
                        .padding(.horizontal)
                    HourlyForecastView(forecastHours: weather.hourlyForecast, isDay: weather.isDay)
                        .padding(.horizontal)
                    DailyForecastView(dailyForecast: weather.dailyForecast, isDay: weather.isDay)
                        .padding(.horizontal)
                    Spacer()
                } else if viewModel.error != nil {
                    Text("Error loading weather.")
                        .foregroundColor(.red)
                        .padding(.horizontal)
                } else {
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .applyBackgroundColor()
            .background(backgroundColor)
        }
        .onReceive(locationManager.$location) { location in
            guard let location = location else { return }
            
            if let prev = previousLocation, location.distance(from: prev) < 500 {
                return
            }
            previousLocation = location
            viewModel.loadWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                locationManager.startUpdatingLocation()
            }
        }
    }
}
#if DEBUG
struct ContentView_Previews_Success: PreviewProvider {
    static var previews: some View {
        let mockUseCase = MockWeatherUseCaseForPreview(shouldSucceed: true, mockWeatherModel: MockupData.weatherModel)
        let viewModel = WeatherViewModel(weatherUseCase: mockUseCase)
        viewModel.loadWeather(lat: 0, lon: 0)
        return ContentView(viewModel: viewModel)
    }
}

struct ContentView_Previews_WithError: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: DIContainer.shared.makeMockWeatherViewModel(shouldSucceed: false, mockError: NetworkError.invalidURL))
    }
}

struct ContentView_Previews_Loading: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel(weatherUseCase: MockWeatherUseCaseForPreview(shouldSucceed: false, mockWeatherModel: nil)))
    }
}

#endif
