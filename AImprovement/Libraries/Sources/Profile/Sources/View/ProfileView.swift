//
//  SwiftUIView.swift
//
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import SwiftUI
import UIComponents
import Providers

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


public struct ProfileView<Model: ProfileViewModel>: View {
    @State private var loading: Bool = false
    
    public init(model: Model) {
        self._model = StateObject(wrappedValue: model)
    }
    
    public var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            headline
            Image(.profile)
                .padding(.top, 46)
            nickMail
                .padding(.top, 16)
            description
                .padding(.top, 16)
            Spacer()
            if loading {
                ProgressView()
            } else {
                logoutButton
            }
        }
        .onTapGesture {
            self.hideKeyboard()
            model.updateDescription()
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
    }
    
    private var headline: some View {
        Text("Профиль")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var logoutButton: some View {
        MainButton(model: .text("Выйти"), style: .accentFilled, action: {
            loading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                loading = false
                model.onLogoutTap()
            }
        })
    }
    
    private var nickMail: some View {
        VStack (alignment: .center, spacing: 5) {
            Text(model.getProfile().nick.components(separatedBy: " ").joined(separator: "\n"))
                .font(Fonts.mainText)
                .multilineTextAlignment(.center)
            Text(model.getProfile().email)
                .font(Fonts.subText)
                .foregroundStyle(.gray)
        }
        
    }
    
    private var description: some View {
        VStack (alignment: .center, spacing: 5) {
            HStack {
                Text("о себе")
                    .font(Fonts.subText)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            TextField(
                "расскажите о себе",
                text: $model.description,
                axis: .vertical
            )
            .focused($isFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(10)
            .lineLimit(4...20)
            .overlay(
                RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                    .stroke(
                        isFocused ? Static.Colors.accent : .black
                    )
            )
            
        }
    }
    
    @StateObject private var model: Model
    @FocusState private var isFocused: Bool
    @State private var desc: String = ""
    
}

private enum Static {
    enum Colors {
        static let accent: Color = Color(.accent)
    }
}

//#Preview {
//    ProfileView(model: ProfileViewModelImpl(onLogoutAction: {}))
//}
