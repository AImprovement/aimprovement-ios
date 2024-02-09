import SwiftUI
import UIComponents

struct AuthorizationView: View {

    var body: some View {
        Text(Static.Layout.text)
            .font(Static.Fonts.main)
        TextFieldView(
            model: TextFieldView.Model(validate: { text in
                if text.count > 6 {
                    return true
                }
                return false },
                                       placeholder: "timcook@apple.com"
                                      )
        )
    }
}

private enum Static {
    enum Layout {
        static let text: String = "Регистрация"
    }

    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Bold", size: 35)
    }
}

#Preview {
    AuthorizationView()
}
