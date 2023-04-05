
import Foundation

struct MemberRepo {
    static func getAllMembers(user: User) async throws -> [Member] {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/member")!)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "GET"
        let (data, _) = try! await URLSession.shared.data(for: request)
        return try! JSONDecoder().decode([Member].self, from: data)
    }
    
    static func getMembers(user: User, workspace: Workspace) async throws -> [Member] {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/workspace/\(workspace.id)/member")!)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "GET"
        let (data, _) = try! await URLSession.shared.data(for: request)
        return try! JSONDecoder().decode([Member].self, from: data)
    }
    
    static func postMember(user: User, member: Member, workspace: Workspace) async throws {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/workspace/\(workspace.id)/member?mid=\(member.id)")!)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "POST"
        let (data, _) = try! await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!)
    }
    
    static func deleteMember(user: User, member: Member, workspace: Workspace) async throws {
        var request = URLRequest(url: URL(string: "https://cse118.com/api/v1/workspace/\(workspace.id)/member?mid=\(member.id)")!)
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user.accessToken)"
        ]
        request.httpMethod = "DELETE"
        let (data, _) = try! await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8)!)
    }
}
