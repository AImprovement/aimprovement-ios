import SwiftUI
import Materials
import Providers
import UIComponents
import Types

public struct SearchView<Model: SearchViewModel>: View {
    @State private var loading: Bool = true
    
    public init(model: Model) {
        self._model = StateObject(wrappedValue: model)
    }
    
    public var body: some View {
        NavigationStack {
            VStack {
                if loading {
                    Spacer()
                    ProgressView()
                } else {
                    materialsList(model.materials)
                }
                Spacer()
                questionField
                    .background {
                        Color.white
                    }
            }
        }
        .onAppear {
            model.getMaterials()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.loading.toggle()
            }
            
        }
    }
    
    @State private var inputState: TextFieldView.InputState = .idle
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
                NavigationLink(destination: MaterialDetailView(material: material)) {
                    MessageBubble(
                        message: Types.Message(id: ind, type: .material(material)),
                        onLikeClicked: {
                            model.onLikedMaterial(ind: ind)
                        },
                        onTap: {}
                    )
                    .padding(.horizontal, CommonConstants.horizontalPadding)
                    .padding(.bottom, 19)
                }
            }
        }
        .refreshable {
            
        }
        .scrollClipDisabled()
        .scrollDismissesKeyboard(.immediately)
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
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
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
