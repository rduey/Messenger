
import Foundation

struct ChannelRepo {
    static func getChannels(user: User, workspace: Workspace) async throws -> [Channel] {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/workspace/\(workspace.id)/channel")!)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "GET"
        let (data, _) = try! await URLSession.shared.data(for: request)
        return try! JSONDecoder().decode([Channel].self, from: data)
    }
    
    static func postChannel(user: User, workspace: Workspace, name: String) async throws {
        let message = NewChannel(name: name)
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/workspace/\(workspace.id)/channel")!)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(message)
        let (data, _) = try! await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!)
    }
    
    static func deleteChannel(user: User, channel: Channel) async throws {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/channel/\(channel.id)")!)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "DELETE"
        let (data, _) = try! await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!)
    }
}

struct NewChannel: Codable {
    let name: String
}
