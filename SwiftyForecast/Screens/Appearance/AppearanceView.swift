//
//  AppearanceView.swift
//  Swifty Forecast
//
//  Created by Pawel Milek on 1/2/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct AppearanceView: View {
    enum Constant {
        static let height = CGFloat(410)
    }

    @Environment(\.colorScheme) var colorScheme
    @AppStorage("userThemeSetting") var userThemeSetting: AppearanceTheme = .systemDefault
    @State private var circleOffset = CGSize.zero
    var onAppearanceChange: () -> Void

    var body: some View {
        VStack(spacing: 35) {
            Circle().fill(userThemeSetting.color(colorScheme).gradient)
                .frame(maxWidth: 150, maxHeight: 150)
                .mask {
                    Rectangle()
                        .overlay {
                            Circle()
                                .offset(x: circleOffset.width, y: circleOffset.height)
                                .blendMode(.destinationOut)
                        }
                }
            VStack(spacing: 10) {
                Text("Appearance")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Choose a day or night.\nCustomize your interface.")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(.accent)
            .fontDesign(.monospaced)
            Picker("User Theme Settings", selection: $userThemeSetting) {
                ForEach(AppearanceTheme.allCases, id: \.self) { item in
                    Text(item.rawValue)
                        .foregroundStyle(.accent)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: Constant.height)
        .background(Color(.systemBackground))
        .clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal, 15)
        .environment(\.colorScheme, colorScheme)
        .onAppear {
            let isDark = colorScheme == .dark
            setCircleOffset(isDark: isDark)
        }
        .onChange(of: colorScheme) {
            let isDark = colorScheme == .dark
            setCircleOffset(isDark: isDark)
        }
        .onChange(of: userThemeSetting) {
            let isDark = userThemeSetting == .dark
            setCircleOffset(isDark: isDark)
            onAppearanceChange()
        }
    }

    private func setCircleOffset(isDark: Bool) {
        withAnimation(.bouncy) {
            circleOffset = CGSize(width: isDark ? 30 : 150, height: isDark ? -25 : -150)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AppearanceView { }
}
