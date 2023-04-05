/*
 Resources:
 https://developer.apple.com/documentation/swiftui/navigationlink
 */
import SwiftUI

struct MessageList: View {
    @EnvironmentObject var model: ViewModel
    let workspace: Workspace
    let channel: Channel
    var body: some View {
        VStack() {
            List {
                ForEach(model.messages) {message in
                    MessageCard(message: message, channel: channel, workspace: workspace)
                }
            }
            .navigationTitle(channel.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    NewMessageView(channel: channel)
                } label: {
                    Label("New Message", systemImage: "plus.square")
                        .fontWeight(.regular)
                }
            }
        }
        .onAppear {
            model.getMessages(channel: channel)
        }
    }
}
