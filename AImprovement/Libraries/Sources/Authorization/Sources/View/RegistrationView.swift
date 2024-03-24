import SwiftUI
import UIComponents

public struct RegistrationView<Model: RegistrationViewModel>: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var action: Int? = 0

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            CustomNavBar(onBack: {
                presentationMode.wrappedValue.dismiss()
            })
            headline
            textField
            Spacer()
            MainButton(model: .text("Дальше"), style: .accentFilled, action: {
                self.action = 1
            })
            nextButton
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
        .navigationBarBackButtonHidden()
    }

    private var headline: some View {
        Text("Регистрация", bundle: .module)
            .font(Fonts.heading)
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

    private var nextButton: some View {
        NavigationLink(
            destination: FullRegistrationView(model: model),
            tag: 1,
            selection: $action
        ) {
            EmptyView()
        }
    }

    @ObservedObject private var model: Model
    @State private var emailInput: String = ""
    @State private var emailInputState: TextFieldView.InputState = .idle

}

#Preview {
    RegistrationView(model: RegistrationViewModelImpl(textFieldValidator: TextFieldValidatorImpl(), onRegistrationComplete: {}))
}
