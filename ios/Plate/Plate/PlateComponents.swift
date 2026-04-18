//
//  PlateComponents.swift
//  Plate
//
//  Created by Renee Gowda on 4/18/26.
//

import Foundation
import SwiftUI

struct PlateTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .tracking(1.5)
                .foregroundColor(Color(hex: "4A7C59"))
            
            TextField(placeholder, text: $text)
                .font(.system(size: 15))
                .foregroundColor(Color(hex: "2C4A35"))
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "E8E4DA"), lineWidth: 1)
                )
        }
    }
}

struct PlateSecureField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .tracking(1.5)
                .foregroundColor(Color(hex: "4A7C59"))
            
            SecureField(placeholder, text: $text)
                .font(.system(size: 15))
                .foregroundColor(Color(hex: "2C4A35"))
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "E8E4DA"), lineWidth: 1)
                )
        }
    }
}

struct ProgressDotsView: View {
    let step: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<2) { i in
                RoundedRectangle(cornerRadius: 99)
                    .fill(i == step ? Color(hex: "4A7C59") : Color(hex: "C8D9C8"))
                    .frame(width: i == step ? 24 : 8, height: 5)
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

struct PlateEmailField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .tracking(1.5)
                .foregroundColor(Color(hex: "4A7C59"))
            
            TextField(placeholder, text: $text)
                .font(.system(size: 15))
                .foregroundColor(Color(hex: "2C4A35"))
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "E8E4DA"), lineWidth: 1)
                )
        }
    }
}
