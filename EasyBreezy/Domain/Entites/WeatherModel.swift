//
//  WeatherModel.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 27/3/2568 BE.
//

import Foundation

struct WeatherModel {
    var name: String
    var isDay: IsDayOrNight
    var astrio: AstroModel?
    var currentForecast: ForecastModel
    var hourlyForecast: [ForecastModel]
    var dailyForecast: [DailyForecast]
}

extension WeatherModel {
    struct DailyForecast:Identifiable {
        var id = UUID()
        var dateEpoch: Int
        var dailyForecast: ForecastDayModel.Forecast
    }
}
