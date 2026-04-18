//
//  ActionButtonsView.swift
//  Plate
//
//  Created by Renee Gowda on 4/18/26.
//

import Foundation
import SwiftUI

struct ActionButtonsView: View {
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {}) {
                Text("take me there 🗺️")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(hex: "4F46E5"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.white)
                    .cornerRadius(99)
            }

            Button(action: {}) {
                Text("show me other options")
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.75))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(.white.opacity(0.12))
                    .cornerRadius(99)
            }
        }
    }
}
