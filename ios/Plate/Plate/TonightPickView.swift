import SwiftUI

struct TonightPickView: View {
    var body: some View {
        ZStack {
            Color(hex: "F5F0E8").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("TONIGHT FOR YOU")
                        .font(.system(size: 11, weight: .semibold))
                        .tracking(2)
                        .foregroundColor(Color(hex: "4A7C59"))
                    
                    Text("Collegetown")
                        .font(.custom("Georgia", size: 48))
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "2C4A35"))
                    
                    Text("Bagels")
                        .font(.custom("Georgia", size: 48))
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "2C4A35"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top, 60)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "FAFAF7"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(hex: "E8E4DA"), lineWidth: 1)
                        )
                    
                    VStack(spacing: 8) {
                        Text("🥯")
                            .font(.system(size: 64))
                        Text("avocado toast on\neverything bagel")
                            .font(.custom("Georgia", size: 15))
                            .italic()
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(hex: "2C4A35"))
                    }
                    .padding(.vertical, 56)
                }
                
                HStack(spacing: 10) {
                    TagCard(text: "fresh\n+ filling", color: "D4EDE1", textColor: "2C4A35")
                    TagCard(text: "campus\nfave", color: "FAE0D4", textColor: "7C3D4A")
                }
                
                HStack(spacing: 10) {
                    StatCard(label: "avg price", value: "$9")
                    StatCard(label: "closes", value: "9 PM")
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("take me there →")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color(hex: "7C3D4A"))
                        .cornerRadius(99)
                }
                .padding(.bottom, 48)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct TagCard: View {
    let text: String
    let color: String
    let textColor: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold))
            .multilineTextAlignment(.center)
            .foregroundColor(Color(hex: textColor))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 36)
            .background(Color(hex: color))
            .cornerRadius(16)
    }
}

struct StatCard: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .tracking(1)
                .foregroundColor(Color(hex: "4A7C59"))
            Text(value)
                .font(.custom("Georgia", size: 28))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "2C4A35"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 36)
        .background(Color(hex: "FAFAF7"))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "E8E4DA"), lineWidth: 1)
        )
        .cornerRadius(16)
    }
}
