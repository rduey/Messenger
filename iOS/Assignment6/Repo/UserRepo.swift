
import Foundation

struct UserRepo {
    static func login(credentials: Credentials) async throws -> (User, Bool) {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/login")!)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(credentials)
        let (data, response) = try! await URLSession.shared.data(for: request)
        if (response as! HTTPURLResponse).statusCode != 200 {
            return (User(id: UUID(), name: "", accessToken: ""), false)
        }
        return (try! JSONDecoder().decode(User.self, from: data), true)
    }
}
