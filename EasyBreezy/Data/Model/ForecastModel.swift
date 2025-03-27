//
//  ForecastModel.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 24/3/2568 BE.
//

import Foundation
import SwiftUICore

struct ForecastModel:Identifiable, Codable {
    var id = UUID()
    var lastUpdateEpoch: Int?
    var lastUpdate: String?
    var timeEpoch: Int?
    var time: String?
    var tempC: Double
    var tempF: Double
    var isDay: IsDayOrNight
    var condition: ConditionModel
    var windMph: Double
    var windKph: Double
    var windDegree: Int
    var windDir: WindDirection
    var pressureMb: Double
    var pressureIn: Double
    var precipMm: Double
    var precipIn: Double
    var humidity: Int
    var cloud: Int
    var feelslikeC: Double
    var feelslikeF: Double
    var windchillC: Double
    var windchillF: Double
    var heatindexC: Double
    var heatindexF: Double
    var dewpointC: Double
    var dewpointF: Double
    var visKm: Double
    var visMiles: Double
    var uv: Double
    var gustMph: Double
    var gustKph: Double
    var airQuality: AirQualityModel?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdateEpoch = "last_update_epoch"
        case lastUpdate = "last_update"
        case timeEpoch = "time_epoch"
        case time = "time"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition = "condition"
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity = "humidity"
        case cloud = "cloud"
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case airQuality = "air_quality"
    }
}

enum IsDayOrNight: Int, Codable {
    case day = 1
    case night = 0

    var color: Color {
        switch self {
        case .day:
            return Color(red: 3/255, green: 113/255, blue: 187/255).opacity(0.7)
        case .night:
            return Color(red: 38/255, green: 38/255, blue: 38/255).opacity(0.7)
        }
    }
}


enum WindDirection: String, Codable {
    case n = "N"
    case nne = "NNE"
    case ne = "NE"
    case ene = "ENE"
    
    case e = "E"
    case ese = "ESE"
    case se = "SE"
    case sse = "SSE"
    
    case s = "S"
    case ssw = "SSW"
    case sw = "SW"
    case wsw = "WSW"
    
    case w = "W"
    case wnw = "WNW"
    case nw = "NW"
    case nnw = "NNW"
    
    var degrees: Double {
        switch self {
        case .n:
            return 0
        case .nne:
            return 22.5
        case .ne:
            return 45
        case .ene:
            return 67.5
        case .e:
            return 90
        case .ese:
            return 112.5
        case .se:
            return 135
        case .sse:
            return 157.5
        case .s:
            return 180
        case .ssw:
            return 202.5
        case .sw:
            return 225
        case .wsw:
            return 247.5
        case .w:
            return 270
        case .wnw:
            return 292.5
            case .nw:
            return 315
        case .nnw:
            return 337.5
        }
    }
}
