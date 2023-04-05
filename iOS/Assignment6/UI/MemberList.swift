import SwiftUI

struct MemberList: View {
    @EnvironmentObject var model: ViewModel
    let workspace: Workspace
    var body: some View {
        VStack() {
            List {
                ForEach(model.members) {member in
                    MemberCard(workspace: workspace, member: member, add: false)
                }
            }
            .navigationTitle("Members")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink {
                        AddMemberList(workspace: workspace)
                    } label: {
                        Label("Add Member", systemImage: "plus.square")
                            .fontWeight(.regular)
                    }
                }
            }
        }
        .onAppear {
            model.getMembers(workspace: workspace)
        }
    }
}
