import SwiftUI

struct CreateView: View {
    @EnvironmentObject var model: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let type: String
    var workspace: Workspace = Workspace(id: UUID(), name: "", owner: UUID(), channels: 0)
    var body: some View {
        VStack() {
            TextField("Name", text: $model.new)
                .frame(width: 330)
                .border(.blue.opacity(0.3))
                .accessibilityIdentifier("Message")
                .textFieldStyle(.roundedBorder)
            HStack() {
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                    model.new = ""
                }
                Button("OK") {
                    if (type == "Channel") {
                        model.postChannel(workspace: workspace)
                        model.getChannels(workspace: workspace)
                    }
                    else {
                        model.postWorkspace()
                        model.getWorkspaces()
                    }
                    model.new = ""
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(!(model.new.count > 4))
            }
            Spacer()
            Spacer()
        }
        .navigationTitle("New \(type)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
