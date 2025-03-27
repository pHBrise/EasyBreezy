//
//  LocationModel.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 24/3/2568 BE.
//

struct LocationModel: Codable {
    var name: String
    var region: String
    var country: String
    var lat: Double
    var lon: Double
    var tzId: String
    var localtimeEpoch: Double
    var localtime: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case region
        case country
        case lat
        case lon
        case tzId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
