//
//  SignUpStep1View.swift
//  Plate
//
//  Created by Renee Gowda on 4/18/26.
//

import SwiftUI

struct SignUpStep1View: View {
    @Binding var currentScreen: Int
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var age = ""
    
    var body: some View {
        ZStack {
            Color(hex: "F5F0E8").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: { currentScreen = 0 }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 13, weight: .semibold))
                            Text("back")
                                .font(.system(size: 14))
                        }
                        .foregroundColor(Color(hex: "4A7C59"))
                    }
                    Spacer()
                    ProgressDotsView(step: 0)
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.bottom, 32)
                
                Text("nice to meet\nyou")
                    .font(.custom("Georgia", size: 36))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "2C4A35"))
                    .lineSpacing(2)
                
                Text("step 1 of 2")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "4A7C59"))
                    .padding(.top, 6)
                    .padding(.bottom, 36)
                
                VStack(spacing: 20) {
                    PlateTextField(label: "NAME", placeholder: "your name", text: $name)
                    PlateEmailField(label: "EMAIL", placeholder: "you@email.com", text: $email)
                    PlateSecureField(label: "PASSWORD", placeholder: "········", text: $password)
                    PlateTextField(label: "AGE", placeholder: "21", text: $age)
                }
                
                Spacer()
                
                Button(action: { currentScreen = 2 }) {
                    Text("next →")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color(hex: "4A7C59"))
                        .cornerRadius(99)
                }
                .padding(.bottom, 48)
            }
            .padding(.horizontal, 32)
        }
    }
}
