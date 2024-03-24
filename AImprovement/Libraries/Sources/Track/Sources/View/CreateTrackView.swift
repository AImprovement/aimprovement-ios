//
//  SwiftUIView.swift
//
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import SwiftUI
import UIComponents
import Materials
import MaterialsProvider

public struct CreateTrackFirstView<Model: CreateTrackViewModel>: View {
    var state: Bool = true
    @State private var isPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationModeF: Binding<PresentationMode>

    
    
    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    public var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            CustomNavBar(onBack: {
                presentationModeF.wrappedValue.dismiss()
            })
            headline
            questionField
            if state {
                Button(action: {
                    isPresented = true
                }) {
                    MessageBubble(type: .material(MaterialsProviderImpl().getMaterials()[0], .bordered, onLikeClicked: {
                        print("hello")
                    }))
                }
            }
            Spacer()
            VStack {
                saveButton
                Text("Сбросить")
                    .font(Fonts.subText)
                    .foregroundStyle(.gray)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isPresented) {
            MaterialDetailView(model: MaterialDetailViewModelImpl())
        }
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
        TextFieldView(model: .question(placeholder: "задайте вопрос...", onSubmit: {}), input: $input, inputState: $inputState)
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
    CreateTrackFirstView(model: CreateTrackViewModelImpl())
}
