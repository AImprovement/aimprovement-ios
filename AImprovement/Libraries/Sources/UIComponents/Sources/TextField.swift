import SwiftUI

public struct TextFieldView: View {

    public enum Model {
        case email
        case usernameOrEmail
        case password
    }

    public enum InputState {
        case idle
        case incorrect
    }

    @Binding var input: String
    @Binding var inputState: InputState

    public init(
        model: Model,
        input: Binding<String>,
        inputState: Binding<InputState>
    ) {
        self.model = model
        self._input = input
        self._inputState = inputState
    }

    public var body: some View {
        VStack(alignment: .leading) {
            switch model {
            case .email:
                Text(Static.Strings.emailHeadline)
                    .font(Static.Fonts.headline)
                TextField(Static.Strings.emailPlaceholder, text: $input)
                    .frame(
                        width: Static.Layout.width,
                        height: Static.Layout.height
                    )
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: Static.Layout.cornerRadius)
                            .stroke(
                                emailFieldIsFocused ? .black : .gray,
                                lineWidth: Static.Layout.borderWidth
                            )
                    )
                    .focused($emailFieldIsFocused)
                    .disableAutocorrection(true)
                if case .incorrect = inputState {
                    Text("Incorrect")
                        .foregroundStyle(.red)
                }
            case .usernameOrEmail:
                Text(Static.Strings.usernameOrEmailHeadline)
                    .font(Static.Fonts.headline)
                TextField(
                    Static.Strings.usernameOrEmailPlaceholder,
                    text: $input
                )
                    .frame(
                        width: Static.Layout.width,
                        height: Static.Layout.height
                    )
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: Static.Layout.cornerRadius)
                            .stroke(
                                emailFieldIsFocused ? .black : .gray,
                                lineWidth: Static.Layout.borderWidth
                            )
                    )
                    .focused($emailFieldIsFocused)
                    .disableAutocorrection(true)
                if case .incorrect = inputState {
                    Text("Incorrect")
                        .foregroundStyle(.red)
                }
            case .password:
                Text(Static.Strings.passwordHeadline)
                    .font(Static.Fonts.headline)
                SecureField(Static.Strings.passwordHeadline, text: $input)
                    .frame(
                        width: Static.Layout.width,
                        height: Static.Layout.height
                    )
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: Static.Layout.cornerRadius)
                            .stroke(
                                emailFieldIsFocused ? .black : .gray,
                                lineWidth: Static.Layout.borderWidth
                            )
                    )
                    .focused($emailFieldIsFocused)
                    .disableAutocorrection(true)
                if case .incorrect = inputState {
                    Text("Incorrect")
                        .foregroundStyle(.red)
                }
            }
        }
    }

    @FocusState private var emailFieldIsFocused: Bool
    private let model: Model
}

private enum Static {
    enum Layout {
        static let width: CGFloat = 312
        static let height: CGFloat = 58
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }

    enum Fonts {
        static let headline: Font = Font.custom("CoFoSans-Regular", size: 20)
    }

    enum Strings {
        static let emailHeadline: String = "email"
        static let emailPlaceholder: String = "duck@apple.com"
        static let usernameOrEmailHeadline: String = "Никнейм / email"
        static let usernameOrEmailPlaceholder: String = "timcook"
        static let passwordHeadline: String = "Пароль"
        static let passwordPlaceholder: String = "Пароль"
    }
}
