import SwiftUI
import UIComponents

public struct LoginView<Model: LoginViewModel>: View {

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
            TextFieldView(model: .usernameOrEmail, input: $usernameOrEmailInput, inputState: $usernameOrEmailInputState)
                .onSubmit {
                    if !model.isValid(.usernameOrEmail(usernameOrEmailInput)) {
                        usernameOrEmailInputState = .incorrect
                    }
                }
            TextFieldView(model: .password, input: $passwordInput, inputState: $passwordInputState)
                .onSubmit {
                    if !model.isValid(.usernameOrEmail(passwordInput)) {
                        passwordInputState = .incorrect
                    }
                }
            MainButton(
                model: .text("не помню пароль"),
                style: .custom(
                    MainButton.Style.Model(
                        backgroundColor: .clear,
                        textColor: Static.Colors.hint,
                        font: Static.Fonts.hintButton,
                        shouldApplyPadding: false
                    )
                ),
                action: {}
            )
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 36)
            Spacer()
            MainButton(
                model: .text("Дальше"),
                style: .accentFilled,
                action: {}
            )
        }
        .padding(.top, 103)
        .padding(.bottom, 24)
        .background(.white)
    }

    @ObservedObject private var model: Model
    @State private var usernameOrEmailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var usernameOrEmailInputState: TextFieldView.InputState = .idle
    @State private var passwordInputState: TextFieldView.InputState = .idle
}

private enum Static {
    enum Layout {
        static let text: String = "Вход"
    }

    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Bold", size: 35)
        static let hintButton: Font = Font.custom("CoFoSans-Regular", size: 15)
    }

    enum Colors {
        static let hint: Color = Color("HintColor", bundle: .main)
    }
}
