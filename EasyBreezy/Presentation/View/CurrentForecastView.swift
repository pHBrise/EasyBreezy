//
//  CurrentView.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 25/3/2568 BE.
//

import SwiftUI

struct CurrentForecastView: View {
    @Environment(\.appBackgroundColor) var backgroundColor
    @State var currentWeather: ForecastModel
    @State var astro: AstroModel?
    @State var isDay: IsDayOrNight?
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .bottom, content: {
                    AsyncImage(url: URL(string: "https:" + currentWeather.condition.icon)!) { phase in
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
                    .frame(width: 48, height: 48)
                    Text("\(currentWeather.tempC, specifier: "%.f")°")
                        .font(.system(size: 42, weight: .bold, design: .default))
                        .foregroundColor(.white)
                })
                .frame(height: 32)
                Text("\(currentWeather.condition.text)")
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text("Feels like \(currentWeather.feelslikeC, specifier: "%.f")°")
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .foregroundColor(.white)
                if let astro = astro {
                    HStack {
                        Image(systemName: "sunrise")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.white)
                        Text("\(astro.sunrise)")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.white)
                        Image(systemName: "sunset")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.white)
                        Text("\(astro.sunset)")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.white)
                    }
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                if let pm25 = currentWeather.airQuality?.pm25 {
                    let aqi = AQICalculator.calculateAQI(for: Double(pm25))
                    Text("AQI: \(aqi)")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    Text("PM2.5: \(pm25, specifier: "%.f") μg/m³")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.white)
                }
                Text("Humidity: \(currentWeather.humidity)%")
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .foregroundColor(.white)
                Text("Wind: \(currentWeather.windKph, specifier: "%.f") km/h")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white)
                Text("Precip: \(currentWeather.precipMm, specifier: "%.f")%")
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .foregroundColor(.white)
                
                
            }
        }
        .padding()
        .background(isDay?.color)
        .cornerRadius(8)
    }
}

#Preview {
    let currentWeather = MockupData.currentForecast
    CurrentForecastView(currentWeather: currentWeather,astro: MockupData.astro, isDay: .day)
}
