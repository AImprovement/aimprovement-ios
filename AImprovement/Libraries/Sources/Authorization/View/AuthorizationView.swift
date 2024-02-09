import SwiftUI
import UIComponents

struct AuthorizationView: View {
    var body: some View {
        Text("hi")
        TextFieldView(model: TextFieldView.Model(validate: { text in
            if text.count > 6 {
                return true
            }
            return false
        }, placeholder: "timcook@apple.com"))
    }
}

#Preview {
    AuthorizationView()
}
