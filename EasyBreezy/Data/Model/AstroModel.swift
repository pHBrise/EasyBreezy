//
//  AstroModel.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 24/3/2568 BE.
//

struct AstroModel: Codable {
    var sunrise: String
    var sunset: String
    var moonrise: String
    var moonset: String
    var moonPhase: String
    var moonIllumination: Int
    var isMoonUp: Int
    var isSunUp: Int
    
    enum CodingKeys: String, CodingKey {
        case sunrise = "sunrise"
        case sunset = "sunset"
        case moonrise = "moonrise"
        case moonset = "moonset"
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}
