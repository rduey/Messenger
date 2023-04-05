import SwiftUI

struct ChannelList: View {
    @EnvironmentObject var model: ViewModel
    let workspace: Workspace
    var body: some View {
        VStack() {
            List {
                ForEach(model.channels) { channel in
                    NavigationLink(destination: MessageList(workspace: workspace, channel: channel)) {
                        ChannelCard(workspace: workspace, channel: channel)
                    }
                    .accessibilityIdentifier(channel.name)
                }
            }
            .navigationTitle(workspace.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    HStack {
                        if (workspace.owner == model.user.id) {
                            NavigationLink {
                                MemberList(workspace: workspace)
                            } label: {
                                Label("Add Members", systemImage: "person.badge.plus")
                                    .fontWeight(.regular)
                            }
                            
                            NavigationLink {
                                CreateView(type: "Channel", workspace: workspace)
                            } label: {
                                Label("New Channel", systemImage: "plus.square")
                                    .fontWeight(.regular)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            model.getChannels(workspace: workspace)
        }
    }
}
