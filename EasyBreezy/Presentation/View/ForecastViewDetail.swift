//
//  ForecastViewDetail.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 26/3/2568 BE.
//
import SwiftUI

struct ForecastViewDetail: View {
    @State var forecast: ForecastModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.appBackgroundColor) var backgroundColor
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack(alignment: .bottom, content: {
                    AsyncImage(url: URL(string: "https:" + forecast.condition.icon)!) { phase in
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
                    Text("\(forecast.tempC, specifier: "%.f")°")
                        .font(.system(size: 42, weight: .bold, design: .default))
                        .foregroundColor(.white)
                })
                .frame(height: 32)
                Text("\(forecast.condition.text)")
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text("Feels like \(forecast.feelslikeC, specifier: "%.f")°")
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .toolbar {
                Button {
                    dismiss()
                } label:{
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}


#Preview {
    if let forecast = MockupData.hourlyForecast.first {
        ForecastViewDetail(forecast: forecast)
    }
}
