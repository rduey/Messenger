import Foundation

struct WorkspaceRepo {
    static func getWorkspaces(user: User) async throws -> [Workspace] {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/workspace")!)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "GET"
        let (data, _) = try! await URLSession.shared.data(for: request)
        return try! JSONDecoder().decode([Workspace].self, from: data)
    }
    
    static func postWorkspace(user: User, name: String) async throws {
        let message = NewWorkspace(name: name)
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/workspace")!)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(message)
        let (data, _) = try! await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!)
    }
    
    static func deleteWorkspace(user: User, workspace: Workspace) async throws {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/workspace/\(workspace.id)")!)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "DELETE"
        let (data, _) = try! await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!)
    }
}

struct NewWorkspace: Codable {
    let name: String
}
