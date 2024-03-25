import SwiftUI
import Chat
import Types
import UIComponents
import Lottie

public struct QuestionView<Model: QuestionViewModel>: View {

    public init(model: Model) {
        self._model = StateObject(wrappedValue: model)
    }

    public var body: some View {
        VStack {
            headline
            Chat.ChatView(messages: model.messages)
            Spacer()
            questionField
        }
        .padding(.horizontal, 35)
        .padding(.bottom, 22)
    }

    @State private var input: String = ""
    @State private var inputState: TextFieldView.InputState = .idle

    @StateObject private var model: Model

    private var headline: some View {
        Text("Какой у вас вопрос?", bundle: .module)
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var questionField: some View {
        TextFieldView(
            model: .question(
                placeholder: model.isSendingAvailable ? "задайте вопрос..." : "ожидайте ответа",
                onSubmit: {
                    guard !input.isEmpty else { return }
                    model.onSubmitTap(question: input)
                    input = ""
                }
            ),
            input: $input,
            inputState: $inputState,
            isSendButtonAvailable: model.isSendingAvailable
        )
    }

}
