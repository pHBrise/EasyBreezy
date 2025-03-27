//
//  AirQuality.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 24/3/2568 BE.
//

import SwiftUICore

struct AirQualityModel: Codable {
    let co: Double?
    let no2: Double
    let o3: Double
    let so2: Double
    let pm25: Double
    let pm10: Double
    let usEpaIndex: AQIColorIndex
    let gbDefraIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case co
        case no2
        case o3
        case so2
        case pm25 = "pm2_5"
        case pm10
        case usEpaIndex = "us-epa-index"
        case gbDefraIndex = "gb-defra-index"
    }
}

enum AQIColorIndex: Int, Codable {
    case good = 1
    case moderate = 2
    case unhealthyForSensitiveGroups = 3
    case unhealthy = 4
    case veryUnhealthy = 5
    case hazardous = 6
    
    var color: Color {
        switch self {
        case .good:
            return .green
        case .moderate:
            return .yellow
        case .unhealthyForSensitiveGroups:
            return .orange
        case .unhealthy:
            return .red
        case .veryUnhealthy:
            return .purple
        case .hazardous:
            return .brown
        }
    }
    
    var description: String {
        switch self {
        case .good:
            return "Good"
        case .moderate:
            return "Moderate"
        case .unhealthyForSensitiveGroups:
            return "Unhealthy for sensitive groups"
        case .unhealthy:
            return "Unhealthy"
        case .veryUnhealthy:
            return "Very unhealthy"
        case .hazardous:
            return "Hazardous"
        }
    }
}
