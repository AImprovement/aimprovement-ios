import SwiftUI
import UIComponents
import Materials
import Providers
import Types
import Lottie

public struct CreateTrackFirstView<Model: TrackViewModel>: View {
    var state: Bool = true
    @State private var isPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    public var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            CustomNavBar(onBack: {
                presentationMode.wrappedValue.dismiss()
            })
            headline
            questionField
            VStack(spacing: 10) {
                materials
                bottomButtons
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isPresented) {
            MaterialDetailView(material: MaterialsProviderImpl().getMaterials()[0])
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
        .onAppear {
            model.onViewAppear()
        }
    }

    private var materials: some View {
        ScrollView {
            if state {
                ForEach(Array(model.materials.enumerated()), id: \.1.id) { ind, material in
                    NavigationLink(destination: MaterialDetailView(material: material)) {
                        MessageBubble(
                            message: Types.Message(id: ind, type: .material(material)),
                            onLikeClicked: {
                                model.onLikedMaterial(ind: ind)
                            },
                            onTap: {
                                isPresented = true
                            }
                        )
                        .padding(.bottom, 19)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
    }

    private var bottomButtons: some View {
        VStack {
            saveButton
            hideButton
        }
    }

    private var saveButton: some View {
        MainButton(model: .text("Сохранить"), style: .accentFilled, action: {
            self.presentationMode.wrappedValue.dismiss()
        })
    }

    private var hideButton: some View {
        Button {
            hideKeyboard()
        } label: {
            Text("Сбросить")
                .font(Fonts.subText)
                .foregroundStyle(.gray)
        }
    }

    private var headline: some View {
        Text("Что хотите развивать?")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
        //        LottieView(animation: .named("question.json"))
        //            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
    }
    
    private var questionField: some View {
        TextFieldView(
            model: .question(
                placeholder: "",
                onSubmit: { }
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
