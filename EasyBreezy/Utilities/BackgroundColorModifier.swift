//
//  Enivi.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 26/3/2568 BE.
//

import SwiftUICore

struct AppBackgroundColorKey: EnvironmentKey {
    static let defaultValue: RadialGradient = RadialGradient(
        gradient: Gradient(colors: [Color.yellow, Color.white, Color.blue, Color.blue, Color.blue, Color.blue]), center: .topLeading,
        startRadius: 0,
        endRadius: 1400
    )
}

extension EnvironmentValues {
    var appBackgroundColor: RadialGradient {
        get { self[AppBackgroundColorKey.self] }
        set { self[AppBackgroundColorKey.self] = newValue }
    }
}

struct BackgroundColorModifier: ViewModifier {
    func body(content: Content) -> some View {
        let backgroundColor = getBackgroundColor(for: Date())
        return content
            .environment(\.appBackgroundColor, backgroundColor)
    }
    
    private func getBackgroundColor(for date: Date) -> RadialGradient {
        let hour = Calendar.current.component(.hour, from: date)
        
        let mornimg = RadialGradient(
            gradient: Gradient(colors: [Color.yellow, Color.blue, Color.blue]), center: .topLeading,
            startRadius: 0,
            endRadius: 1000
        )
        let afternoon = RadialGradient(
            gradient: Gradient(colors: [Color.yellow, Color.blue, Color.blue]), center: .topLeading,
            startRadius: 0,
            endRadius: 1000
        )
        let evening = RadialGradient(
            gradient: Gradient(colors: [Color.blue, Color.black, Color.black]), center: .topLeading,
            startRadius: 0,
            endRadius: 1000
        )
        let night = RadialGradient(
            gradient: Gradient(colors: [Color.blue, Color.black, Color.black]), center: .topLeading,
            startRadius: 0,
            endRadius: 1000
        )
        switch hour {
        case 6..<12: return mornimg
        case 12..<18: return afternoon
        case 18..<21: return evening
        default: return night
        }
    }
}

extension View {
    func applyBackgroundColor() -> some View {
        self.modifier(BackgroundColorModifier())
    }
}
