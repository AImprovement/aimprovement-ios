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
        if messages.isEmpty {
            
        } else {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                                    .padding(.bottom, CommonConstants.verticalTextFieldPadding)
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
                .scrollClipDisabled()
                .scrollIndicators(.hidden)
            }
        }
    }
}
