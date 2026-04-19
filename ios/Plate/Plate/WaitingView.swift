import SwiftUI

struct WaitingView: View {
    @Binding var currentScreen: Int
    let onRecommend: (RecommendResponse) -> Void

    @State private var timeRemaining: TimeInterval = 0
    @State private var dinnerTimeString: String = ""
    @State private var isLaunching = false
    @State private var errorMessage: String?

    private let locationManager = LocationManager()
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(hex: "F5F0E8").ignoresSafeArea()

            VStack(spacing: 0) {
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

                VStack(spacing: 28) {
                    VStack(spacing: 6) {
                        Text("YOUR DINNER TONIGHT")
                            .font(.system(size: 11, weight: .semibold))
                            .tracking(2)
                            .foregroundColor(Color(hex: "4A7C59"))

                        Text(dinnerTimeString.isEmpty ? "—" : dinnerTimeString)
                            .font(.custom("Georgia", size: 36))
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "2C4A35"))
                    }

                    VStack(spacing: 12) {
                        Text("READY IN")
                            .font(.system(size: 11, weight: .semibold))
                            .tracking(2)
                            .foregroundColor(Color(hex: "4A7C59"))

                        HStack(alignment: .bottom, spacing: 8) {
                            CountdownUnit(value: countHours, label: "HRS")

                            Text(":")
                                .font(.custom("Georgia", size: 44))
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "C8D9C8"))
                                .padding(.bottom, 22)

                            CountdownUnit(value: countMinutes, label: "MIN")

                            Text(":")
                                .font(.custom("Georgia", size: 44))
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "C8D9C8"))
                                .padding(.bottom, 22)

                            CountdownUnit(value: countSeconds, label: "SEC")
                        }
                    }

                    if let error = errorMessage {
                        VStack(spacing: 12) {
                            Text(error)
                                .font(.system(size: 13))
                                .foregroundColor(Color(hex: "7C3D4A"))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)

                            Button(action: {
                                errorMessage = nil
                                isLaunching = false
                                launch()
                            }) {
                                Text("try again")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 36)
                                    .padding(.vertical, 14)
                                    .background(Color(hex: "7C3D4A"))
                                    .cornerRadius(99)
                            }
                        }
                    }
                }

                Spacer()

                Text("we'll find your perfect plate when it's time")
                    .font(.system(size: 13))
                    .italic()
                    .foregroundColor(Color(hex: "4A7C59"))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 48)
            }
            .padding(.horizontal, 32)
        }
        .onAppear(perform: setup)
        .onReceive(ticker) { _ in tick() }
    }

    private var countHours: Int   { max(0, Int(timeRemaining)) / 3600 }
    private var countMinutes: Int { (max(0, Int(timeRemaining)) % 3600) / 60 }
    private var countSeconds: Int { max(0, Int(timeRemaining)) % 60 }

    private func setup() {
        dinnerTimeString = UserDefaults.standard.string(forKey: "dinnerTime") ?? ""
        timeRemaining = secondsUntilDinner()
        if timeRemaining <= 0 { launch() }
    }

    private func tick() {
        guard !isLaunching, errorMessage == nil else { return }
        if timeRemaining > 0 {
            timeRemaining -= 1
        }
        if timeRemaining <= 0 {
            launch()
        }
    }

    private func launch() {
        guard !isLaunching else { return }
        isLaunching = true
        Task {
            do {
                let location = try await locationManager.requestLocation()
                let rec = try await NetworkManager.shared.recommend(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
                onRecommend(rec)
            } catch {
                errorMessage = error.localizedDescription
                isLaunching = false
            }
        }
    }

    private func secondsUntilDinner() -> TimeInterval {
        let raw = UserDefaults.standard.string(forKey: "dinnerTime") ?? ""
        let now = Date()
        let cal = Calendar.current
        let formatter = DateFormatter()

        for format in ["h:mm a", "h a"] {
            formatter.dateFormat = format
            if let parsed = formatter.date(from: raw),
               let target = cal.date(
                   bySettingHour: cal.component(.hour, from: parsed),
                   minute: cal.component(.minute, from: parsed),
                   second: 0, of: now) {
                return target.timeIntervalSince(now)
            }
        }
        return 0
    }
}

struct CountdownUnit: View {
    let value: Int
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(hex: "E8E4DA"), lineWidth: 1)
                    )
                    .frame(width: 76, height: 76)

                Text(String(format: "%02d", value))
                    .font(.custom("Georgia", size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "2C4A35"))
            }

            Text(label)
                .font(.system(size: 10, weight: .semibold))
                .tracking(1.5)
                .foregroundColor(Color(hex: "4A7C59"))
        }
    }
}
