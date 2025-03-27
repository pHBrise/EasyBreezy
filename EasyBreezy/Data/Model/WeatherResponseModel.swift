//
//  WeatherResponseModel.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 24/3/2568 BE.
//

struct WeatherResponseModel: Codable {
    var location: LocationModel
    var current: ForecastModel
    var forecast: WeatherResponseModel.Forecast
}

extension WeatherResponseModel  {
    struct Forecast: Codable {
        var forecastday: [ForecastDayModel]
    }
}
