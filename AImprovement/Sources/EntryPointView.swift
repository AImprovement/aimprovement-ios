import SwiftUI
import UIComponents
import Authorization

@MainActor
struct EntryPointView: View {

    @Binding var isAuthorized: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: CommonConstants.stackSpacing) {
                Spacer()
                Text("AImprovement")
                    .font(Static.Fonts.logo)
                    .foregroundColor(.white)
                VStack {
                    loginView
                    registrationView
                }
            }
            .padding(.bottom, 58)
            .background {
                Image(.brandBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
    }

    private var loginView: some View {
        NavigationLink(
            destination: LoginView(
                model: LoginViewModelImpl(
                    textFieldValidator: TextFieldValidatorImpl(),
                    onLoginComplete: {
                        isAuthorized = true
                    }
                )
            )
        ) {
            Text("Войти")
                .font(Static.Fonts.main)
                .foregroundColor(.white)
                .frame(width: CommonConstants.buttonWidth)
                .padding(.vertical, 17)
                .background {
                    RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                        .stroke(.white, lineWidth: 3)
                        .foregroundColor(.clear)
                }
        }
    }

    private var registrationView: some View {
        NavigationLink(
            destination: RegistrationView(
                model: RegistrationViewModelImpl(
                    textFieldValidator: TextFieldValidatorImpl(),
                    onRegistrationComplete: {
                        isAuthorized = true
                    }
                )
            )
        ) {
            Text("Регистрация")
                .font(Static.Fonts.main)
                .foregroundColor(Static.Colors.accent)
                .frame(width: CommonConstants.buttonWidth)
                .padding(.vertical, 17)
                .background {
                    RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                        .foregroundColor(.white)
                }
        }
    }
}

private enum Static {
    enum Fonts {
        static let logo: Font = Font.custom("CoFoSans-Bold", size: 40)
        static let main: Font = Font.custom("CoFoSans-Bold", size: 20)
    }

    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }
}

#Preview {
    EntryPointView(isAuthorized: .constant(true))
}
