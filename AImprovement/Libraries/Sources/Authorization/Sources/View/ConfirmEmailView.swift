import SwiftUI
import UIComponents

public struct ConfirmEmailView<Model: ConfirmEmailViewModel>: View {

    @State private var action: Int? = 0

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack(spacing: 22) {
            headline
            description
            textField
            Spacer()
            MainButton(model: .text("Дальше"), style: .accentFilled, action: {
                self.action = 1
            })
            link
        }
        .padding(.top, 103)
        .padding(.bottom, 24)
        .padding(.horizontal, 31)
    }

    private var link: some View {
        NavigationLink(destination: NewPasswordView(model: NewPasswordViewModelImpl(textFieldValidator: TextFieldValidatorImpl())), tag: 1, selection: $action)
        {
            EmptyView()
        }
    }

    private var headline: some View {
        Text("Регистрация")
            .font(Static.Fonts.main)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var description: some View {
        Group {
            Text("На вашу электронную почту ").font(Static.Fonts.description) +
            Text(model.viewState.email).font(Static.Fonts.email) +
            Text(" было отправлено письмо с кодом").font(Static.Fonts.description)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var textField: some View {
        VStack {
            TextFieldView(
                model: .default(headline: "Код подтверждения", placeholder: "123456"),
                input: $codeInput,
                inputState: $codeInputState
            )
            .onSubmit {
                if !model.isValid(.restoreCode(codeInput)) {
                    codeInputState = .incorrect
                }
            }
            resendCodeButton
        }
    }

    private var resendCodeButton: some View {
        NavigationLink(
            destination: RestorePasswordView(
                model: RestorePasswordViewModelImpl(
                    textFieldValidator: TextFieldValidatorImpl()
                )
            )
        )
        {
            Text("отправить повторно")
                .font(Static.Fonts.hintButton)
                .foregroundColor(Static.Colors.hint)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    @ObservedObject private var model: Model
    @State private var codeInput: String = ""
    @State private var codeInputState: TextFieldView.InputState = .idle
}

private enum Static {
    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Bold", size: 35)
        static let description: Font = Font.custom("CoFoSans-Regular", size: 20)
        static let email: Font = Font.custom("CoFoSans-Bold", size: 20)
        static let hintButton: Font = Font.custom("CoFoSans-Regular", size: 15)
    }

    enum Colors {
        static let hint: Color = Color("HintColor", bundle: .main)
    }
}

#Preview {
    RestorePasswordView(
        model: RestorePasswordViewModelImpl(
            textFieldValidator: TextFieldValidatorImpl()
        )
    )
}
