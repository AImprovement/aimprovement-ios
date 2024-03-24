import SwiftUI
import UIComponents
import MaterialsProvider
import Materials

struct TrackDetailView<Model: TrackDetailViewModel>: View {
    var state: Bool = true
    @State private var isPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            CustomNavBar(onBack: {
                presentationMode.wrappedValue.dismiss()
            })
            headline
            ScrollView {
                if state {
                    card
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isPresented){
            MaterialDetailView(material: MaterialsProviderImpl().getMaterials()[0])
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
    }
    
    private var headline: some View {
        Text("Решения")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var card: some View {
        MessageBubble(type: .material(MaterialsProviderImpl().getMaterials()[0], .bordered, onLikeClicked: {
            print("hello")
        }, onTap: {
            isPresented = true
//            MaterialsProviderImpl().getMaterials()[0]
        }))
    }

    @ObservedObject private var model: Model
}

#Preview {
    TrackDetailView(model: TrackDetailViewModelImpl())
}
