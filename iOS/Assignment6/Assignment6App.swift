
/*
 * Copyright (C) 2022 David C. Harrison. All right reserved.
 *
 * You may not use, distribute, publish, or modify this code without
 * the express written permission of the copyright holder.
 */

import SwiftUI

@main
struct Assignment6App: App {
  var body: some Scene {
    WindowGroup {
      MainView()
            .environmentObject(ViewModel())
    }
  }
}
