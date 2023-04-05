import SwiftUI

struct LoginView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack {
            Spacer()
            Text("CSE118 Assignment 6")
            Image("SlugLogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
            VStack {
                TextField("EMail", text: $model.credentials.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .border(.linearGradient(colors: [.indigo, .yellow], startPoint: .leading, endPoint: .trailing), width: 2)
                SecureField("Password", text: $model.credentials.password)
                    .border(.linearGradient(colors: [.indigo, .yellow], startPoint: .trailing, endPoint: .leading), width: 2)
            }
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: 256)
            Button("Login") {
                model.login()
            }
            Spacer(minLength: 400)
        }
        .ignoresSafeArea(.keyboard)
    }
}
