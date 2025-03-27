//
//  AQICalculator.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 26/3/2568 BE.
//

struct AQICalculator {
    static let pm25Breakpoints: [(low: Double, high: Double, indexLow: Int, indexHigh: Int)] = [
        (0.0, 12.0, 0, 50),
        (12.1, 35.4, 51, 100),
        (35.5, 55.4, 101, 150),
        (55.5, 150.4, 151, 200),
        (150.5, 250.4, 201, 300),
        (250.5, 500.4, 301, 500)
    ]
    
    static func calculateAQI(for pm25: Double) -> Int {
        for range in pm25Breakpoints {
            if pm25 >= range.low && pm25 <= range.high {
                return Int(((Double(range.indexHigh - range.indexLow) / (range.high - range.low)) * (pm25 - range.low)) + Double(range.indexLow))
            }
        }
        return 500
    }
}
