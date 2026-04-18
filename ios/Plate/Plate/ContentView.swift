//
//  ContentView.swift
//  Plate
//
//  Created by Renee Gowda on 4/18/26.
//

import SwiftUI

struct ContentView: View {
    @State private var currentScreen = 0
    
    var body: some View {
        switch currentScreen {
        case 0:
            SplashView(currentScreen: $currentScreen)
        case 1:
            SignUpStep1View(currentScreen: $currentScreen)
        case 2:
            SignUpStep2View(currentScreen: $currentScreen)
        case 3:
            TonightPickView()
        default:
            SplashView(currentScreen: $currentScreen)
        }
    }
}

