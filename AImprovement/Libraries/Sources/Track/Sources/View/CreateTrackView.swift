import SwiftUI
import UIComponents
import Materials
import Providers

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
            ScrollView {
                if state {
                    MessageBubble(type: .material(MaterialsProviderImpl().getMaterials()[0], .bordered, onLikeClicked: {
                        print("hello")
                    }, onTap: {
                        isPresented = true
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
            MaterialDetailView(material: MaterialsProviderImpl().getMaterials()[0])
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
        TextFieldView(
            model: .question(
                placeholder: "задайте вопрос...",
                onSubmit: {
                    hideKeyboard()
                }
            ),
            input: $input,
            inputState: $inputState
        )
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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


#Preview {
    CreateTrackFirstView(model: CreateTrackViewModelImpl())
}
