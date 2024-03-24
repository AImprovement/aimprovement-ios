import SwiftUI
import UIComponents

public struct QuestionView: View {

    public init() {
    }

    public var body: some View {
        headline
            .padding(.top, 15)
            .padding(.horizontal, 35)
        Spacer()
        questionField
            .padding(.horizontal, 35)
            .padding(.bottom, 22)
    }

    @State private var input: String = ""
    @State private var inputState: TextFieldView.InputState = .idle

    private var headline: some View {
        Text("Какой у вас вопрос?", bundle: .module)
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var questionField: some View {
        TextFieldView(model: .question(placeholder: "задайте вопрос..."), input: $input, inputState: $inputState)
    }

}
