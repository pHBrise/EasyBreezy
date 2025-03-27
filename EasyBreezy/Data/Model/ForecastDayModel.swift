//
//  ForecastDayModel.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 24/3/2568 BE.
//



struct ForecastDayModel: Codable {
    var date: String
    var dateEpoch: Int
    var forecastDay: ForecastDayModel.Forecast
    var astro: AstroModel
    var forecastHours: [ForecastModel]
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case dateEpoch = "date_epoch"
        case forecastDay = "day"
        case astro = "astro"
        case forecastHours = "hour"
    }
}


extension ForecastDayModel {
    struct Forecast: Codable {
        var maxtempC: Double
        var maxtempF: Double
        var mintempC: Double
        var mintempF: Double
        var avgtempC: Double
        var avgtempF: Double
        var maxwindMph: Double
        var maxwindKph: Double
        var totalprecipMm: Double
        var totalprecipIn: Double
        var totalsnowCm: Double
        var avgvisKm: Double
        var avgvisMiles: Double
        var avghumidity: Int
        var dailyWillItRain: Int
        var dailyChanceOfRain: Int
        var dailyWillItSnow: Int
        var dailyChanceOfSnow: Int
        var condition: ConditionModel
        var uv: Double
        
        enum CodingKeys: String, CodingKey {
            case maxtempC = "maxtemp_c"
            case maxtempF = "maxtemp_f"
            case mintempC = "mintemp_c"
            case mintempF = "mintemp_f"
            case avgtempC = "avgtemp_c"
            case avgtempF = "avgtemp_f"
            case maxwindMph = "maxwind_mph"
            case maxwindKph = "maxwind_kph"
            case totalprecipMm = "totalprecip_mm"
            case totalprecipIn = "totalprecip_in"
            case totalsnowCm = "totalsnow_cm"
            case avgvisKm = "avgvis_km"
            case avgvisMiles = "avgvis_miles"
            case avghumidity = "avghumidity"
            case dailyWillItRain = "daily_will_it_rain"
            case dailyChanceOfRain = "daily_chance_of_rain"
            case dailyWillItSnow = "daily_will_it_snow"
            case dailyChanceOfSnow = "daily_chance_of_snow"
            case condition = "condition"
            case uv
        }
    }
}

