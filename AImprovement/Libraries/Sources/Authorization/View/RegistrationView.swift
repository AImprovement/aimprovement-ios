import SwiftUI
import UIComponents

public struct RegistrationView<Model: RegistrationViewModel>: View {

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack {
            Text(Static.Layout.text)
                .font(Static.Fonts.main)
                .padding(.bottom, 22)
                .padding(.leading, 31)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextFieldView(model: .usernameOrEmail, input: $emailInput, inputState: $emailInputState)
                .onSubmit {
                    if !model.isValid(.usernameOrEmail(emailInput)) {
                        emailInputState = .incorrect
                    }
                }
            Spacer()
            MainButton(model: .text("Дальше"), style: .accentFilled, action: {})
        }
        .padding(.top, 103)
        .padding(.bottom, 24)
        .background(.white)
    }

    @ObservedObject private var model: Model
    @State private var emailInput: String = ""
    @State private var emailInputState: TextFieldView.InputState = .idle

}

private enum Static {
    enum Layout {
        static let text: String = "Регистрация"
    }

    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Bold", size: 35)
    }
}
