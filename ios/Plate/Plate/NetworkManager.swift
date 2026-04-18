import Foundation

private let baseURL = "http://localhost:5001"
private let useMock = false

struct SignupRequest: Codable {
    var name: String
    var age: Int
    var dietaryRestrictions: String
    var cuisinePreferences: String
    var budget: Int
    var dinnerTime: String
}

struct RecommendRequest: Codable {
    var userId: String
    var latitude: Double
    var longitude: Double
}

struct RecommendResponse: Codable {
    var restaurantName: String
    var dish: String
    var keywords: [String]
    var address: String
    var mapsUrl: String
}

@MainActor
final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let encoder: JSONEncoder = {
        let e = JSONEncoder()
        e.keyEncodingStrategy = .convertToSnakeCase
        return e
    }()

    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()

    func signup(_ body: SignupRequest) async throws -> String {
        if useMock { return "mock-user-id-12345" }
        let data = try await post(path: "/signup", body: body)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let userId = json?["user_id"] as? String else {
            throw URLError(.cannotParseResponse)
        }
        return userId
    }

    func recommend(_ body: RecommendRequest) async throws -> RecommendResponse {
        if useMock {
            return RecommendResponse(
                restaurantName: "The Golden Spoon",
                dish: "Truffle Mushroom Risotto",
                keywords: ["cozy", "vegetarian-friendly", "date night"],
                address: "123 Maple St, San Francisco, CA 94103",
                mapsUrl: "https://maps.apple.com/?q=The+Golden+Spoon"
            )
        }
        let data = try await post(path: "/recommend", body: body)
        return try decoder.decode(RecommendResponse.self, from: data)
    }

    private func post<T: Encodable>(path: String, body: T) async throws -> Data {
        guard let url = URL(string: baseURL + path) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(body)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
