
import Foundation

struct MessageRepo {
    static func getMessages(user: User, channel: Channel) async throws -> [Message] {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/channel/\(channel.id)/message")!)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "GET"
        let (data, _) = try! await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!)
        
        return try! JSONDecoder.javaScriptISO8601().decode([Message].self, from: data)
    }
    
    static func postMessage(user: User, channel: Channel, content: String) async throws {
        let message = NewMessage(content: content)
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/channel/\(channel.id)/message")!)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(message)
        let (data, _) = try! await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!)
    }
    
    static func deleteMessage(user: User, message: Message) async throws {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/message/\(message.id)")!)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "DELETE"
        let (data, _) = try! await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!)
    }
}

struct NewMessage: Codable {
    let content: String
}
