//
//  ContentView.swift
//  Plate
//
//  Created by Renee Gowda on 4/18/26.
//

import SwiftUI

struct ContentView: View {
    @State private var currentScreen = 0
    @StateObject private var signUpViewModel = SignUpViewModel()
    @State private var recommendation: RecommendResponse?

    var body: some View {
        switch currentScreen {
        case 0:
            SplashView(currentScreen: $currentScreen)
        case 1:
            SignUpStep1View(currentScreen: $currentScreen)
                .environmentObject(signUpViewModel)
        case 2:
            SignUpStep2View(currentScreen: $currentScreen)
                .environmentObject(signUpViewModel)
        case 3:
            WaitingView(currentScreen: $currentScreen) { rec in
                recommendation = rec
                currentScreen = 4
            }
        case 4:
            if let recommendation {
                TonightPickView(recommendation: recommendation)
            }
        default:
            SplashView(currentScreen: $currentScreen)
        }
    }
}
