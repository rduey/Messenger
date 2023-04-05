
import SwiftUI

struct WorkspaceCard: View {
    @EnvironmentObject var model: ViewModel
    let workspace: Workspace
    var body: some View {
        if (workspace.owner == model.user.id) {
            HStack() {
                Image(systemName: "folder.badge.person.crop")
                    .foregroundColor(.blue)
                Text("\(workspace.name)")
                Spacer()
                Text("\(workspace.channels)")
                    .opacity(0.4)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    model.deleteWorkspace(workspace: workspace)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        else {
            HStack() {
                Image(systemName: "folder")
                    .foregroundColor(.blue)
                Text("\(workspace.name)")
                Spacer()
                Text("\(workspace.channels)")
                    .opacity(0.4)
            }
        }
    }
}
