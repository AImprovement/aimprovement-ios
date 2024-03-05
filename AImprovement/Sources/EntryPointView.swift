import SwiftUI
import UIComponents
import Authorization

@MainActor
struct EntryPointView: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 22) {
                Spacer()
                Text("AImprovement")
                    .font(Static.Fonts.logo)
                    .foregroundColor(.white)
                VStack {
                    NavigationLink(
                        destination: LoginView(
                            model: LoginViewModelImpl(
                                textFieldValidator: TextFieldValidatorImpl()
                            )
                        )
                    )
                    {
                        Text("Войти")
                            .font(Static.Fonts.main)
                            .foregroundColor(.white)
                            .frame(width: 248)
                            .padding(.vertical, 17)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 3)
                                    .foregroundColor(.clear)
                            }
                    }
                    NavigationLink(
                        destination: RegistrationView(
                            model: RegistrationViewModelImpl(
                                textFieldValidator: TextFieldValidatorImpl()
                            )
                        )
                    )
                    {
                        Text("Регистрация")
                            .font(Static.Fonts.main)
                            .foregroundColor(Static.Colors.accent)
                            .frame(width: 248)
                            .padding(.vertical, 17)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            }
                    }
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
        static let main: Font = Font.custom("CoFoSans-Bold", size: 20)
    }

    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }
}

#Preview {
    EntryPointView()
}
