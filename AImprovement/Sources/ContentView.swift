import SwiftUI
import UIComponents
import Authorization
import Profile
import Questions
import Track

struct ContentView: View {

    init() {
        self._isAuthorized = State(initialValue: false)
    }

    var body: some View {
        MainView()
            .overlay {
                if !isAuthorized {
                    EntryPointView(isAuthorized: $isAuthorized)
                }
            }
    }

    // Add REAL checker
    @State var isAuthorized: Bool

}
