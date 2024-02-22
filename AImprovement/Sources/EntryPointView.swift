import SwiftUI
import UIComponents
import SwiftUIRouter
import Authorization

@MainActor
struct EntryPointView: View {

    @EnvironmentObject private var navigator: Navigator

    var body: some View {
        NavigationStack {
            VStack(spacing: 22) {
                Spacer()
                Text("AImprovement")
                    .font(Static.Fonts.logo)
                    .foregroundColor(.white)
                VStack {
                    MainButton(model: .text("Войти"), style: .bordered, action: navigator.navigate("login"))
                    MainButton(model: .text("Регистрация"), style: .filled, action: {})
                }
            }
            .padding(.bottom, 58)
            .background {
                Image(.brandBackground)
                    .ignoresSafeArea()
            }
        }
    }
}

private enum Static {
    enum Fonts {
        static let logo: Font = Font.custom("CoFoSans-Bold", size: 40)
    }
}

private struct RootRoutes: View {
    var body: some View {
        SwitchRoutes {
            Route("login", content: LoginView(model: LoginViewModelImpl(textFieldValidator: TextFieldValidatorImpl())))

            Route("register", content: RegistrationView(model: RegistrationViewModelImpl(textFieldValidator: TextFieldValidatorImpl())))

            Route {
                Navigate(to: "login", replace: true)
            }
        }
        .navigationTransition()
    }
}

#Preview {
    EntryPointView()
}
