import Foundation

struct Message: Identifiable, Codable {
    let id: UUID
    let member: UUID
    let posted: Date
    let content: String
    
    func getString() -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM dd, yyyy at hh:mm a")
        let str = formatter.string(from: self.posted)
        return str
    }
}
