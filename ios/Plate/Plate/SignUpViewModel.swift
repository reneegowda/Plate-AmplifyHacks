import Foundation

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var age: String = ""
    @Published var dietaryRestrictions: String = ""
    @Published var cuisinePreferences: String = ""
    @Published var dinnerTime: String = ""
    @Published var budget: String = ""

    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func signup() async {
        guard let ageInt = Int(age), let budgetInt = Int(budget) else {
            errorMessage = "Age and budget must be valid numbers."
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let request = SignupRequest(
                name: name,
                age: ageInt,
                dietaryRestrictions: dietaryRestrictions,
                cuisinePreferences: cuisinePreferences,
                budget: budgetInt,
                dinnerTime: dinnerTime
            )
            let userId = try await NetworkManager.shared.signup(request)
            UserDefaults.standard.set(userId, forKey: "userId")
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
