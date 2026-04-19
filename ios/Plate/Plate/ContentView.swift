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
    @State private var recommendError: String?
    private let locationManager = LocationManager()

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
            if let recommendation {
                TonightPickView(recommendation: recommendation)
            } else if let error = recommendError {
                errorView(message: error)
            } else {
                loadingView
                    .task { await fetchRecommendation() }
            }
        default:
            SplashView(currentScreen: $currentScreen)
        }
    }

    private var loadingView: some View {
        ZStack {
            Color(hex: "F5F0E8").ignoresSafeArea()
            VStack(spacing: 16) {
                ProgressView()
                    .tint(Color(hex: "4A7C59"))
                Text("finding your plate…")
                    .font(.custom("Georgia", size: 18))
                    .italic()
                    .foregroundColor(Color(hex: "2C4A35"))
            }
        }
    }

    private func errorView(message: String) -> some View {
        ZStack {
            Color(hex: "F5F0E8").ignoresSafeArea()
            VStack(spacing: 20) {
                Text("something went wrong")
                    .font(.custom("Georgia", size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "2C4A35"))
                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "4A7C59"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                Button(action: {
                    recommendError = nil
                }) {
                    Text("try again")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 14)
                        .background(Color(hex: "7C3D4A"))
                        .cornerRadius(99)
                }
            }
        }
    }

    private func fetchRecommendation() async {
        do {
            let location = try await locationManager.requestLocation()
            recommendation = try await NetworkManager.shared.recommend(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        } catch {
            recommendError = error.localizedDescription
        }
    }
}
