import SwiftUI
import UIComponents
import Types
import MaterialsProvider

public struct SearchView<Model: SearchViewModel>: View {

    public init(model: Model) {
        self._model = StateObject(wrappedValue: model)
    }

    public var body: some View {
        Group {
            VStack {
                materialsList(model.materials)
                Spacer()
                questionField
            }
        }
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            model.getMaterials()
        }
    }

    @State private var inputState: TextFieldView.InputState = .idle
    @State private var materials: [Types.Material] = []
    @State private var searchText: String = ""

    var filteredItems: [Types.Material] {
        return model.materials.filter { item in
            searchText.isEmpty || item.title.lowercased().contains(searchText.lowercased())
        }
    }

    @ViewBuilder
    private func materialsList(_ materials: [Types.Material]) -> some View {
        ScrollView {
            ForEach(Array(filteredItems.enumerated()), id: \.1.id) { ind, material in
                MessageBubble(
                    type: .material(
                        material,
                        .bordered,
                        onLikeClicked: {
                            model.onLikedMaterial(ind: ind)
//                            self.materials = model.getMaterials()
                        }
                    )
                )
                .padding(.bottom, 19)
            }
        }
        .scrollIndicators(.hidden)
    }

    private var questionField: some View {
        TextFieldView(
            model: .search(
                placeholder: "что вас интересует?",
                onSubmit: {
                    searchText = ""
                }
            ),
            input: $searchText,
            inputState: $inputState
        )
    }

    @StateObject private var model: Model

}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
