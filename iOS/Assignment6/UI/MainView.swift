/*
 * Copyright (C) 2022 David C. Harrison. All right reserved.
 *
 * You may not use, distribute, publish, or modify this code without
 * the express written permission of the copyright holder.
 *
 * Resources:
 * https://developer.apple.com/documentation/swiftui/textfield
 */

import SwiftUI

struct MainView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack() {
            if !model.authorized {
                LoginView()
            }
            else {
                NavigationStack {
                    WorkspaceList()
                }
            }
        }
//        .onAppear {
//            model.getPosts()
//        }
    }
}

#if !TESTING
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
