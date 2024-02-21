import SwiftUI
import UIComponents

public struct RegistrationView<Model: RegistrationViewModel>: View {

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack {
            headline
            textField
            Spacer()
            MainButton(model: .text("Дальше"), style: .accentFilled, action: {})
        }
        .padding(.top, 103)
        .padding(.bottom, 24)
        .padding(.leading, 31)
        .background(.white)
    }

    private var headline: some View {
        Text("Регистрация", bundle: .module)
            .font(Static.Fonts.main)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var textField: some View {
        TextFieldView(
            model: .default(headline: "email", placeholder: "timcook@apple.com"),
            input: $emailInput,
            inputState: $emailInputState
        )
        .onSubmit {
            if !model.isValid(.usernameOrEmail(emailInput)) {
                emailInputState = .incorrect
            }
        }
    }

    @ObservedObject private var model: Model
    @State private var emailInput: String = ""
    @State private var emailInputState: TextFieldView.InputState = .idle

}

private enum Static {
    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Bold", size: 35)
    }
}

#Preview {
    RegistrationView(model: RegistrationViewModelImpl(textFieldValidator: TextFieldValidatorImpl()))
}
