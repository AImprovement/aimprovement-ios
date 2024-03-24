import SwiftUI
import UIComponents
import Authorization
import Profile
import Questions
import Track
import Providers

struct ContentView: View {

    init() {
        self._isAuthorized = State(initialValue: false)
    }

    var body: some View {
        MainView(isAuthorized: $isAuthorized)
            .overlay {
                if !isAuthorized {
                    EntryPointView(isAuthorized: $isAuthorized)
                }
            }
    }

    // Add REAL checker
    @State var isAuthorized: Bool

}
