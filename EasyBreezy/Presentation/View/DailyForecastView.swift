//
//  DailyForecastView.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 27/3/2568 BE.
//

import SwiftUI

struct DailyForecastView: View {
    @State var dailyForecast: [WeatherModel.DailyForecast]
    @State var isDay: IsDayOrNight?
    var body: some View {
        VStack(alignment: .leading, spacing: 2, content: {
            Text("Daily Forecast")
                .font(.system(size: 12, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
            VStack(spacing: 4) {
                ForEach(dailyForecast) { forecast in
                    DailyForcastRowView(forcast: forecast)
                }
            }
        })
        .padding()
        .padding(.bottom, 12)
        .background(isDay?.color)
        .cornerRadius(8)
    }
}

#Preview {
    DailyForecastView(dailyForecast: MockupData.dailyForecast, isDay: .day)
}
