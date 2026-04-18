//
//  SplashView.swift
//  Plate
//
//  Created by Renee Gowda on 4/18/26.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @Binding var currentScreen: Int
    
    var body: some View {
        ZStack {
            Color(hex: "F5F0E8").ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                VStack(spacing: 12) {
                    Text("ʃ ʃ ʃ")
                        .font(.system(size: 28))
                        .foregroundColor(Color(hex: "4A7C59"))
                    
                    Text("plate")
                        .font(.custom("Georgia", size: 52))
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "2C4A35"))
                    
                    Text("DINNER, SORTED.")
                        .font(.system(size: 12, weight: .medium))
                        .tracking(2.5)
                        .foregroundColor(Color(hex: "4A7C59"))
                }
                
                Spacer()
                
                VStack(spacing: 14) {
                    Button(action: { currentScreen = 1 }) {
                        Text("get started")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color(hex: "4A7C59"))
                            .cornerRadius(99)
                    }
                    
                    Button(action: { currentScreen = 3 }) {
                        Text("i have an account")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(hex: "4A7C59"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 99)
                                    .stroke(Color(hex: "4A7C59"), lineWidth: 1.5)
                            )
                    }
                }
                .padding(.bottom, 48)
            }
            .padding(.horizontal, 32)
        }
    }
}
