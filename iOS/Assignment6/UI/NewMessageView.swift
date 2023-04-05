/*
 Resources:
 https://stackoverflow.com/questions/56513568/ios-swiftui-pop-or-dismiss-view-programmatically
 */

import SwiftUI

struct NewMessageView: View {
    @EnvironmentObject var model: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let channel: Channel
    var body: some View {
        VStack() {
            TextEditor(text: $model.newMessage)
                .frame(width: 330, height: 200)
                .border(.blue.opacity(0.3))
                .accessibilityIdentifier("Message")
            HStack() {
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                    model.newMessage = ""
                }
                .accessibilityIdentifier(channel.name)
                Button("OK") {
                    model.postMessage(channel: channel)
                    model.getMessages(channel: channel)
                    model.newMessage = ""
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(!(model.newMessage.count > 4))
            }
            Spacer()
            Spacer()
        }
        .navigationTitle("New Message")
        .navigationBarTitleDisplayMode(.inline)
    }
}
