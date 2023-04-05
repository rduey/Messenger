import Foundation

struct Channel: Identifiable, Codable {
    let id: UUID
    let name: String
    let messages: Int
}
