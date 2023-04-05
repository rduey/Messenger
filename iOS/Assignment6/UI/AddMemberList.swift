import SwiftUI

struct AddMemberList: View {
    @EnvironmentObject var model: ViewModel
    let workspace: Workspace
    var body: some View {
        VStack() {
            List {
                ForEach(model.otherMembers()) {member in
                    MemberCard(workspace: workspace, member: member, add: true)
                }
            }
            .navigationTitle("Members")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            model.getMembers(workspace: workspace)
        }
    }
}
