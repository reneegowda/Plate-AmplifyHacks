//
//  SignUpStep2View.swift
//  Plate
//
//  Created by Renee Gowda on 4/18/26.
//

import SwiftUI

struct SignUpStep2View: View {
    @Binding var currentScreen: Int
    @State private var dietary = ""
    @State private var cuisine = ""
    @State private var dinnerTime = "7:30 PM"
    @State private var budget = "$15-25"
    
    var body: some View {
        ZStack {
            Color(hex: "F5F0E8").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: { currentScreen = 1 }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 13, weight: .semibold))
                            Text("back")
                                .font(.system(size: 14))
                        }
                        .foregroundColor(Color(hex: "4A7C59"))
                    }
                    Spacer()
                    ProgressDotsView(step: 1)
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.bottom, 32)
                
                Text("your taste")
                    .font(.custom("Georgia", size: 36))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "2C4A35"))
                
                Text("step 2 of 2")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "4A7C59"))
                    .padding(.top, 6)
                    .padding(.bottom, 36)
                
                VStack(spacing: 20) {
                    PlateTextField(label: "DIETARY RESTRICTIONS", placeholder: "e.g. vegetarian, no nuts", text: $dietary)
                    PlateTextField(label: "CUISINE PREFERENCES", placeholder: "e.g. Thai, Italian", text: $cuisine)
                    
                    HStack(spacing: 14) {
                        PlateTextField(label: "DINNER TIME", placeholder: "7:30 PM", text: $dinnerTime)
                        PlateTextField(label: "BUDGET", placeholder: "$15-25", text: $budget)
                    }
                }
                
                Spacer()
                
                Button(action: { currentScreen = 3 }) {
                    Text("let's eat →")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color(hex: "7C3D4A"))
                        .cornerRadius(99)
                }
                .padding(.bottom, 48)
            }
            .padding(.horizontal, 32)
        }
    }
}
