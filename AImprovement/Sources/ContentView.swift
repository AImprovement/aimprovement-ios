import SwiftUI
import UIComponents
import Authorization
import Profile
import Questions
import Track
import MaterialsProvider

struct ContentView: View {

    @ObservedObject var container: AppContainer = AppContainer()

    var body: some View {
        if isAuthorized {
            MainView()
        } else {
            EntryPointView()
//            IndividualTrackView(model: IndividualTrackViewModelImpl())
        }
    }

    // Add REAL checker
    private let isAuthorized: Bool = true

}
