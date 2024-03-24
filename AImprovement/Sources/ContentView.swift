import SwiftUI
import UIComponents
import Authorization
import Profile
import Questions

struct ContentView: View {

    @ObservedObject var container: AppContainer = AppContainer()

    var body: some View {
        if isAuthorized {
            MainView()
        } else {
            EntryPointView()
        }
    }

    // Add REAL checker
    private let isAuthorized: Bool = true

}
