//
//  PreviewWeatherModel.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 25/3/2568 BE.
//

import SwiftUI
import Combine

struct MockupData {
    static let location = LocationModel(name: "Bangkok", region: "Bangkok", country: "Thailand", lat: 13.7563, lon: 100.5018, tzId: "Asia/Bangkok", localtimeEpoch: 1679888400, localtime: "2023-03-27 15:00")
    static let airQuality = AirQualityModel(co: 1028.6, no2: 12.025, o3: 183.0, so2: 12.765, pm25: 51.8, pm10: 54.39, usEpaIndex: .unhealthyForSensitiveGroups, gbDefraIndex: 6)

    static let currentForecast = ForecastModel(
        lastUpdateEpoch: 1679887800,
        lastUpdate: "2023-03-27 14:50",
        timeEpoch: 1679888400,
        time: "2023-03-27 15:00",
        tempC: 32.0,
        tempF: 89.6,
        isDay: .day,
        condition: ConditionModel(text: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png", code: 1003),
        windMph: 6.7,
        windKph: 10.8,
        windDegree: 180,
        windDir: .s,
        pressureMb: 1011.0,
        pressureIn: 29.85,
        precipMm: 0.0,
        precipIn: 0.0,
        humidity: 62,
        cloud: 44,
        feelslikeC: 35.8,
        feelslikeF: 96.4,
        windchillC: 32.0,
        windchillF: 89.6,
        heatindexC: 35.8,
        heatindexF: 96.4,
        dewpointC: 24.2,
        dewpointF: 75.6,
        visKm: 10.0,
        visMiles: 6.0,
        uv: 7.0,
        gustMph: 9.4,
        gustKph: 15.1,
        airQuality: airQuality
    )
    static let astro = AstroModel(sunrise: "06:14 AM", sunset: "06:24 PM", moonrise: "05:58 AM", moonset: "06:33 PM", moonPhase: "Waxing Gibbous", moonIllumination: 99, isMoonUp: 1, isSunUp: 1)
    static let hourlyForecast: [ForecastModel] = [
        ForecastModel(timeEpoch: Int(Date().timeIntervalSince1970) + 3600, time: "09:00", tempC: 31.0, tempF: 87.8, isDay: .day, condition: ConditionModel(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png", code: 1000), windMph: 7.0, windKph: 11.3, windDegree: 190, windDir: .s, pressureMb: 1011.0, pressureIn: 29.85, precipMm: 0.0, precipIn: 0.0, humidity: 65, cloud: 10, feelslikeC: 34.5, feelslikeF: 94.1, windchillC: 31.0, windchillF: 87.8, heatindexC: 34.5, heatindexF: 94.1, dewpointC: 24.5, dewpointF: 76.1, visKm: 10.0, visMiles: 6.0, uv: 8.0, gustMph: 9.0, gustKph: 14.5, airQuality: airQuality),
        ForecastModel(timeEpoch: Int(Date().timeIntervalSince1970) + 7200, time: "10:00", tempC: 33.0, tempF: 91.4, isDay: .day, condition: ConditionModel(text: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png", code: 1003), windMph: 8.0, windKph: 12.9, windDegree: 200, windDir: .s, pressureMb: 1010.0, pressureIn: 29.83, precipMm: 0.0, precipIn: 0.0, humidity: 60, cloud: 30, feelslikeC: 36.8, feelslikeF: 98.2, windchillC: 33.0, windchillF: 91.4, heatindexC: 36.8, heatindexF: 98.2, dewpointC: 24.0, dewpointF: 75.2, visKm: 10.0, visMiles: 6.0, uv: 9.0, gustMph: 10.0, gustKph: 16.1, airQuality: airQuality)
        // Add more hourly forecasts as needed
    ]
    static let dailyForecast: [WeatherModel.DailyForecast] = [
        WeatherModel.DailyForecast(
            dateEpoch: Int(Date().timeIntervalSince1970) + (24 * 3600),
            dailyForecast: ForecastDayModel.Forecast(
                maxtempC: 34.0,
                maxtempF: 93.2,
                mintempC: 26.0,
                mintempF: 78.8,
                avgtempC: 30.0,
                avgtempF: 86.0,
                maxwindMph: 9.0,
                maxwindKph: 14.4,
                totalprecipMm: 0.0,
                totalprecipIn: 0.0,
                totalsnowCm: 0.0,
                avgvisKm: 10.0,
                avgvisMiles: 6.0,
                avghumidity: 65,
                dailyWillItRain: 0,
                dailyChanceOfRain: 0,
                dailyWillItSnow: 0,
                dailyChanceOfSnow: 0,
                condition: ConditionModel(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png", code: 1000),
                uv: 9.0
            )
        ),
        WeatherModel.DailyForecast(
            dateEpoch: Int(Date().timeIntervalSince1970) + (2 * 24 * 3600),
            dailyForecast: ForecastDayModel.Forecast(
                maxtempC: 33.0,
                maxtempF: 91.4,
                mintempC: 25.0,
                mintempF: 77.0,
                avgtempC: 29.0,
                avgtempF: 84.2,
                maxwindMph: 10.0,
                maxwindKph: 16.1,
                totalprecipMm: 0.5,
                totalprecipIn: 0.02,
                totalsnowCm: 0.0,
                avgvisKm: 9.0,
                avgvisMiles: 5.0,
                avghumidity: 70,
                dailyWillItRain: 1,
                dailyChanceOfRain: 70,
                dailyWillItSnow: 0,
                dailyChanceOfSnow: 0,
                condition: ConditionModel(text: "Patchy rain possible", icon: "//cdn.weatherapi.com/weather/64x64/day/176.png", code: 1063),
                uv: 8.0
            )
        )
        // Add more daily forecasts as needed
    ]
    static let weatherModel = WeatherModel(
        name: MockupData.location.name,
        isDay: .day,
        astrio: MockupData.astro,
        currentForecast: MockupData.currentForecast,
        hourlyForecast: MockupData.hourlyForecast,
        dailyForecast: MockupData.dailyForecast
    )
}

// MARK: - Mock Weather Use Case for Preview

#if DEBUG
class MockWeatherUseCaseForPreview: WeatherUseCaseProtocol {
    var shouldSucceed = true
    var mockWeatherModel: WeatherModel?
    var mockError: Error?

    init(shouldSucceed: Bool = true, mockWeatherModel: WeatherModel? = MockupData.weatherModel, mockError: Error? = nil) {
        self.shouldSucceed = shouldSucceed
        self.mockWeatherModel = mockWeatherModel
        self.mockError = mockError
    }

    func execute(lat: Double, lon: Double) -> AnyPublisher<WeatherModel, Error> {
        if shouldSucceed {
            if let model = mockWeatherModel {
                return Just(model)
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
                return Fail(error: NetworkError.unknown(NSError(domain: "Mock", code: 0, userInfo: nil)))
                    .eraseToAnyPublisher()
            }
        }
    }
}

extension DIContainer {
    func makeMockWeatherViewModel(shouldSucceed: Bool = true, mockWeatherModel: WeatherModel? = MockupData.weatherModel, mockError: Error? = nil) -> WeatherViewModel {
        return WeatherViewModel(weatherUseCase: MockWeatherUseCaseForPreview(shouldSucceed: shouldSucceed, mockWeatherModel: mockWeatherModel, mockError: mockError))
    }
}
#endif
