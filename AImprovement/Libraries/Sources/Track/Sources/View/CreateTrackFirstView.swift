//
//  SwiftUIView.swift
//
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import SwiftUI
import UIComponents
import MaterialsProvider


public struct CreateTrackFirstView<Model: CreateTrackFirstViewModel>: View {
    var state: Bool = true
    @State var showingPopup = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: CommonConstants.stackSpacing) {
                headline
                questionField
                if state {
                    MessageBubble(type: .material(MaterialsProviderImpl().getMaterials()[1], .bordered, onLikeClicked: {
                        print("hello")
                    }))
                }
                Spacer()
                VStack {
                    saveButton
                    Text("Сбросить")
                        .font(Fonts.subText)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(.top, CommonConstants.horizontalPadding)
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
    }
    
    private var saveButton: some View {
        MainButton(model: .text("Сохранить"), style: .accentFilled, action: {
            self.presentationMode.wrappedValue.dismiss()
        })
    }
    
    private var headline: some View {
        Text("Что хотите развивать?")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var questionField: some View {
        TextFieldView(model: .question(placeholder: "задайте вопрос..."), input: $input, inputState: $inputState)
    }
    
    
    @ObservedObject private var model: Model
    @State private var input: String = ""
    @State private var inputState: TextFieldView.InputState = .idle
}

private enum Static {
    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }
}

#Preview {
    CreateTrackFirstView(model: CreateTrackFirstViewModelImpl())
}