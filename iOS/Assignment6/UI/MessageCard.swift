/*
 Resources:
 https://developer.apple.com/documentation/swiftui/view/swipeactions(edge:allowsfullswipe:content:)
 */
import SwiftUI

struct MessageCard: View {
    @EnvironmentObject var model: ViewModel
    let message: Message
    let channel: Channel
    let workspace: Workspace
    var body: some View {
        if (message.member == model.user.id || workspace.owner == model.user.id) {
            VStack(alignment: .leading) {
                let member = model.allMembers.filter{ $0.id == message.member }.first
                Text(member!.name)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("\(message.content)")
                    .multilineTextAlignment(.leading)
                HStack(){
                    Spacer()
                    Text("\(message.getString())")
                        .font(.caption)
                        .multilineTextAlignment(.trailing)
                }
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    model.deleteMessage(message: message, channel: channel)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        else {
            VStack(alignment: .leading) {
                let member = model.allMembers.filter{ $0.id == message.member }.first
                Text(member!.name)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("\(message.content)")
                    .multilineTextAlignment(.leading)
                HStack(){
                    Spacer()
                    Text("\(message.getString())")
                        .font(.caption)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        
    }
}
