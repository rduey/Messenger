
import SwiftUI

struct ChannelCard: View {
    @EnvironmentObject var model: ViewModel
    let workspace: Workspace
    let channel: Channel
    var body: some View {
        if (workspace.owner == model.user.id) {
            HStack() {
                Text("\(channel.name)")
                Spacer()
                Text("\(channel.messages)")
                    .opacity(0.4)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    model.deleteChannel(workspace: workspace, channel: channel)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        else {
            HStack() {
                Text("\(channel.name)")
                Spacer()
                Text("\(channel.messages)")
                    .opacity(0.4)
            }
        }
            
    }
}
