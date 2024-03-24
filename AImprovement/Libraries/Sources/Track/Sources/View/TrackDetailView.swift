//
//  SwiftUIView.swift
//  
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import SwiftUI
import UIComponents
import MaterialsProvider

struct TrackDetailView<Model: TrackDetailViewModel>: View {
    var state: Bool = true

    
    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    var body: some View {
            VStack(spacing: CommonConstants.stackSpacing) {
                headline
                if state {
                    card
                    card
                    card
                }
                Spacer()
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
        MessageBubble(type: .material(MaterialsProviderImpl().getMaterials()[1], .bordered, onLikeClicked: {
            print("hello")
        }))
    }
    
    
    @ObservedObject private var model: Model
}

#Preview {
    TrackDetailView(model: TrackDetailViewModelImpl())
}
