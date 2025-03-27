//
//  HourForecastColumnView.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 26/3/2568 BE.
//

import SwiftUI

struct HourlyForecastColumnView: View {
    @State var forecastHour: ForecastModel
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            if let time = forecastHour.timeEpoch ?? forecastHour.lastUpdateEpoch {
                let date = Date(timeIntervalSince1970: TimeInterval(time))
                Text("\(date.formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundColor(.white)
            } else {
                Text("NOW")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundColor(.white)
            }
            AsyncImage(url: URL(string: "https:" + forecastHour.condition.icon)!) { phase in
                switch phase {
                case .failure:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                case .success(let image):
                    image.resizable()
                default:
                    ProgressView()
                }
            }
            .frame(width: 32, height: 32)
            Text("\(forecastHour.tempC, specifier: "%.f")°")
                .font(.system(size: 18, weight: .semibold, design: .default))
                .foregroundColor(.white)
            if let airQuality = forecastHour.airQuality {
                let aqi = AQICalculator.calculateAQI(for: airQuality.pm25)
                VStack(alignment: .center, spacing: 0) {
                    Text("AQI")
                        .font(.system(size: 8, weight: .light))
                        .foregroundColor(.white)
                    Text("\(aqi)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(4)
                .background(airQuality.usEpaIndex.color)
                .cornerRadius(4)
            }
            VStack {
                Image(systemName: "location.north.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.primary, .blue)
                    .frame(width: 14, height: 14)
                    .rotationEffect(Angle(degrees: forecastHour.windDir.degrees + Double(forecastHour.windDegree)))
                    .animation(.easeInOut, value: forecastHour.windDir.degrees + Double(forecastHour.windDegree))
                Text("\(forecastHour.windKph, specifier: "%.f")km/h")
                    .font(.system(size: 12, weight: .light))
            }
            VStack {
                Image(systemName: "humidity")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.blue, .gray)
                Text("\(forecastHour.humidity)%")
                    .font(.system(size: 12, weight: .light))
            }
            VStack {
                Text("UV: \(forecastHour.uv, specifier: "%.f")")
                    .font(.system(size: 12, weight: .light))
            }
        }
        .frame(width: 64)
    }
}

#Preview {
    if let forecast = MockupData.hourlyForecast.first {
        HourlyForecastColumnView(forecastHour: forecast)
    }
}
