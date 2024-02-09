import SwiftUI

public struct TextFieldView: View {

    public struct Model {
        let validate: (_ text: String) -> Bool
        let placeholder: String

        public init(validate: @escaping (_: String) -> Bool, placeholder: String) {
            self.validate = validate
            self.placeholder = placeholder
        }
    }

    public init(model: Model, input: String = "", emailFieldIsFocused: Bool = false) {
        self.model = model
        self.input = input
        self.emailFieldIsFocused = emailFieldIsFocused
    }

    @State private var input: String = ""
    @FocusState private var emailFieldIsFocused: Bool
    private var model: Model

    public var body: some View {
        TextField(model.placeholder, text: $input)
            .frame(width: Static.Layout.width, height: Static.Layout.height)
            .padding(.horizontal, 15)
            .overlay(
                RoundedRectangle(cornerRadius: Static.Layout.cornerRadius)
                    .stroke(
                        emailFieldIsFocused ? .black : .gray,
                        lineWidth: Static.Layout.borderWidth
                    )
            )
            .focused($emailFieldIsFocused)
            .onSubmit {
//                if !model.validate(input) {
//                    .foregroundStyle(.red)
//                }
            }
            .disableAutocorrection(true)
    }
}

private enum Static {
    enum Layout {
        static let width: CGFloat = 307
        static let height: CGFloat = 58
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }
}

#Preview {
    TextFieldView(
        model: TextFieldView.Model(
            validate: { text in
                return false
            },
            placeholder: "geek@apple.com"
        )
    )
}
