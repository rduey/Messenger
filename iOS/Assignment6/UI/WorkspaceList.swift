/*
 Resources:
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-toolbar-and-add-buttons-to-it
 */
import SwiftUI

struct WorkspaceList: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack() {
            if model.workspaces.isEmpty {
                ProgressView()
            }
            else {
                List {
                    ForEach(model.workspaces) { workspace in
                        NavigationLink(destination: ChannelList(workspace: workspace)) {
                            WorkspaceCard(workspace: workspace)
                        }
                        .accessibilityIdentifier(workspace.name)
                    }
                }
                .navigationTitle("Workspaces")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(
                            action: { model.authorized = false },
                            label: { Image(systemName: "arrow.backward.square") })
                        .fontWeight(.regular)
                        .accessibilityIdentifier("Logout")
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        NavigationLink {
                            CreateView(type: "Workspace")
                        } label: {
                            Label("New Workspace", systemImage: "plus.square")
                                .fontWeight(.regular)
                        }
                    }
                }
            }
        }
        .onAppear {
            model.getWorkspaces()
            model.getAllMembers()
        }
    }
}
