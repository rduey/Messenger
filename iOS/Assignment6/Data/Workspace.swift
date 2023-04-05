import Foundation

struct Workspace: Identifiable, Codable {
    let id: UUID
    let name: String
    let owner: UUID
    let channels: Int
}
