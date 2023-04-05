/*
 Resources:
 https://jayeshkawli.ghost.io/everything-about-swipe-actions-modifier-in-swiftui/
 */
import SwiftUI

struct MemberCard: View {
    @EnvironmentObject var model: ViewModel
    let workspace: Workspace
    let member: Member
    let add: Bool
    var body: some View {
        if (add) {
            HStack() {
                Text("\(member.name)")
                Spacer()
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button() {
                    model.addMember(member: member, workspace: workspace)
                    model.getMembers(workspace: workspace)
                } label: {
                    Label("Add", systemImage: "person.badge.plus").foregroundColor(.green)
                }.tint(.green)
            }
        }
        else {
            HStack() {
                Text("\(member.name)")
                Spacer()
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    model.removeMember(member: member, workspace: workspace)
                    model.getMembers(workspace: workspace)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
            
    }
}
