import SwiftUI
import UIComponents

public struct QuestionView<Model: QuestionViewModel>: View {

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack {
            headline
            Spacer()
            questionField
        }
        .onTapGesture {
            hideKeyboard()
        }
        .padding(.horizontal, 35)
        .padding(.bottom, 22)
    }

    @State private var input: String = ""
    @State private var inputState: TextFieldView.InputState = .idle

    @ObservedObject private var model: Model

    private var headline: some View {
        Text("Какой у вас вопрос?", bundle: .module)
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var questionField: some View {
        TextFieldView(
            model: .question(
                placeholder: "задайте вопрос...",
                onSubmit: {
                    hideKeyboard()
                    model.getMaterials(for: input)
                }
            ),
            input: $input,
            inputState: $inputState
        )
    }

}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
