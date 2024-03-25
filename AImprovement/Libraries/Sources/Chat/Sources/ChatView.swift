import SwiftUI
import Combine
import Types
import UIComponents

public struct ChatView: View {

    var messages: [Types.Message]

    public init(messages: [Types.Message]) {
        self.messages = messages
    }

    public var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .onReceive(Just(messages)) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                    }
                    .onAppear {
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                    }
                }
            }
        }
    }
}

struct LoadingText: View {
    var text: String
    var color: Color = .black

    @State var dotsCount = 0

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(text)
                .foregroundColor(color) +
            Text(".")
                .foregroundColor(dotsCount > 0 ? color : .clear) +
            Text(".")
                .foregroundColor(dotsCount > 1 ? color : .clear) +
            Text(".")
                .foregroundColor(dotsCount > 2 ? color : .clear)
        }
        .animation(.easeOut(duration: 0.2), value: dotsCount)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()) { _ in dotsAnimation() }
        .onAppear(perform: dotsAnimation)
    }

    func dotsAnimation() {
        withAnimation {
            dotsCount = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                dotsCount = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation {
                dotsCount = 2
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation {
                dotsCount = 3
            }
        }
    }
}
