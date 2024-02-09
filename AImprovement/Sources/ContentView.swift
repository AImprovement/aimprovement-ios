import SwiftUI
import UIComponents

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(Font.custom("CoFoSans-Bold", size: 26))
        }
        .padding()
    }
}
