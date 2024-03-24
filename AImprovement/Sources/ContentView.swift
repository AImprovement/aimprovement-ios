import SwiftUI
import UIComponents
import Authorization
import Questions

struct ContentView: View {

    @ObservedObject var container: AppContainer = AppContainer()

    var body: some View {
        if isAuthorized {
            QuestionView()
        } else {
            EntryPointView()
        }
    }

    // Add REAL checker
    private let isAuthorized: Bool = false

}
