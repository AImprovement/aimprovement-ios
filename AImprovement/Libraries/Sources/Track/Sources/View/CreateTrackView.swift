import SwiftUI
import UIComponents
import Materials
import Providers
import Types

public struct CreateTrackFirstView<Model: TrackViewModel>: View {

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
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
        .onAppear {
            model.resetFilteredMaterials()
        }
    }

    private var materials: some View {
        ScrollView {
            ForEach(model.filteredMaterials) { material in
                NavigationLink(destination: MaterialDetailView(material: material)) {
                    MessageBubble(
                        message: Types.Message(id: material.id, type: .material(material)),
                        onLikeClicked: {
                            model.onLikedMaterial(ind: material.id)
                            model.getMaterialsForGoal(input)
                        },
                        onTap: { }
                    )
                    .padding(.bottom, 19)
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
            if !input.isEmpty {
                model.createNewTrack(name: input)
            }
            self.presentationMode.wrappedValue.dismiss()
        })
    }

    private var hideButton: some View {
        Button {
            input = ""
            model.resetFilteredMaterials()
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
    }
    
    private var questionField: some View {
        TextFieldView(
            model: .question(
                placeholder: "",
                onSubmit: { 
                    model.getMaterialsForGoal(input)
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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
