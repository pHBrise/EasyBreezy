//
//  DailyForcastRowView.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 27/3/2568 BE.
//

import SwiftUI

struct DailyForcastRowView: View {
    @State var forcast : WeatherModel.DailyForecast
    var body: some View {
        HStack{
            let date = Date(timeIntervalSince1970: TimeInterval(forcast.dateEpoch))
            Text("\(date.formatted(.dateTime.weekday()))")
                .font(.system(size: 14, weight: .medium, design: .default))
                .foregroundColor(.white)
                .frame(width: 40)
            AsyncImage(url: URL(string: "https:" + forcast.dailyForecast.condition.icon)!) { phase in
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
            Spacer()
            Text("\(forcast.dailyForecast.maxtempC, specifier: "%.f")°")
                .font(.system(size: 18, weight: .semibold, design: .default))
                .foregroundColor(.red)
            Text("\(forcast.dailyForecast.mintempC, specifier: "%.f")°")
                .font(.system(size: 18, weight: .semibold, design: .default))
                .foregroundColor(.green)
            Spacer()
            Image(systemName: "humidity")
                .foregroundColor(.white)
            Text("\(forcast.dailyForecast.avghumidity)%")
                .font(.system(size: 14, weight: .regular, design: .default))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "wind")
                .foregroundColor(.white)
            Text("\(forcast.dailyForecast.avgvisKm, specifier: "%.f") km/h")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    DailyForcastRowView(forcast: MockupData.dailyForecast.first!)
}
