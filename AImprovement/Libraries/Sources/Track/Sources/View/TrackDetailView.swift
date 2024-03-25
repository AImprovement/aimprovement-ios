import SwiftUI
import UIComponents
import Providers
import Materials
import Types

struct TrackDetailView<Model: TrackViewModel>: View {
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
            track
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isPresented){
            MaterialDetailView(material: MaterialsProviderImpl().getMaterials()[0])
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
        .onAppear {
            model.fetchMaterialsForTrack()
        }
    }

    private var track: some View {
        ScrollView {
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
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
    }

    private var headline: some View {
        Text("Решения")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }

    private var card: some View {
        MessageBubble(
            message: Types.Message(id: 0, type: .material(MaterialsProviderImpl().getMaterials()[0])),
            onLikeClicked: {},
            onTap: {
                isPresented = true
            }
        )
    }

    @ObservedObject private var model: Model
}
