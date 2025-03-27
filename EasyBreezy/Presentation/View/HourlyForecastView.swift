//
//  Untitled.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 26/3/2568 BE.
//

import SwiftUI

struct HourlyForecastView: View {
    @Environment(\.appBackgroundColor) var appBackgroundColor
    @State private var selectedForecastHour: ForecastModel?
    @State var forecastHours: [ForecastModel]
    @State var isDay: IsDayOrNight?
    var body: some View {
        VStack(alignment: .leading, spacing: 2, content: {
            Text("Hourly Forecast")
                .font(.system(size: 12, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding(.horizontal, 18)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(forecastHours) { hour in
                        Button {
                            selectedForecastHour = hour
                        } label: {
                            HourlyForecastColumnView(forecastHour: hour)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 4)
            }
        })
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(isDay?.color)
        .cornerRadius(8)
        .sheet(item: $selectedForecastHour) { hour in
            ForecastViewDetail(forecast: hour)
        }
    }
}

#Preview {
    HourlyForecastView(forecastHours: MockupData.hourlyForecast, isDay: .day)
}
