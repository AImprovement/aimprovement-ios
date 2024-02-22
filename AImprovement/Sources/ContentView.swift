import SwiftUI
import UIComponents
import Authorization
import SwiftUIRouter

struct ContentView: View {

    @ObservedObject var container: AppContainer = AppContainer()

    var body: some View {
        Router {
            TabView {
                NavigationStack {
                    EmptyView()
                        .navigationTitle("Home")
                }
                .tabItem {
                    Label("Tab 1", systemImage: "1.circle")
                }
                Text("hihi")
                    .tabItem {
                        Label("Tab 2", systemImage: "2.circle")
                    }
            }
            .overlay {
                EntryPointView()
            }
        }
    }

}
