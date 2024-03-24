import SwiftUI
import UIComponents

public struct NewPasswordView<Model: NewPasswordViewModel>: View {

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack(spacing: 22) {
            headline
            VStack {
                newPasswordTextField
                repeatPasswordTextField
            }
            Spacer()
            MainButton(model: .text("Сменить пароль"), style: .accentFilled, action: {})
        }
        .padding(.top, 103)
        .padding(.bottom, 24)
        .padding(.horizontal, 31)
    }

    private var headline: some View {
        Text("Восстановление пароля")
            .font(Static.Fonts.main)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var newPasswordTextField: some View {
        TextFieldView(
            model: .password(headline: "Новый пароль", placeholder: "your password here"),
            input: $newPasswordInput,
            inputState: $newPasswordInputState
        )
        .onSubmit {
            if !model.isValid(.password(newPasswordInput)) {
                newPasswordInputState = .incorrect
            }
        }
    }

    private var repeatPasswordTextField: some View {
        TextFieldView(
            model: .password(headline: "Повтор пароля", placeholder: "your password here"),
            input: $repeatPasswordInput,
            inputState: $repeatPasswordInputState
        )
        .onSubmit {
            if !model.isValid(.password(repeatPasswordInput)) {
                repeatPasswordInputState = .incorrect
            }
        }
    }

    @ObservedObject private var model: Model
    @State private var newPasswordInput: String = ""
    @State private var repeatPasswordInput: String = ""
    @State private var newPasswordInputState: TextFieldView.InputState = .idle
    @State private var repeatPasswordInputState: TextFieldView.InputState = .idle
}

private enum Static {
    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Bold", size: 35)
    }
}

#Preview {
    NewPasswordView(model: NewPasswordViewModelImpl(textFieldValidator: TextFieldValidatorImpl()))
}
