//
//  SwiftUIView.swift
//
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import SwiftUI
import UIComponents
import Providers

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

public struct ReviewView: View {
    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage
        } else {
            onImage
        }
    }
    
    public var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    if number > rating {
                        offImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Static.Colors.accent)
                            .frame(width: 30, height: 30)
                    } else {
                        onImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Static.Colors.accent)
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
}


public struct CreateReviewView<Model: CreateReviewViewModel>: View {
    @Environment(\.dismiss) var dismiss
    @State private var rating = 3
    
    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    public var body: some View {
        VStack  {
            VStack(alignment: .leading,spacing: CommonConstants.stackSpacing) {
                Text("Оставьте свой отзыв")
                    .font(Fonts.heading)
                    .foregroundStyle(.black)
                ReviewView(rating: $rating)
                reviewText
                Spacer()
                
            }
            createButton
        }
        .onTapGesture {
            self.hideKeyboard()
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .padding(.top, 20)
        .background(.white)
    }
    
    
    private var reviewText: some View {
        VStack (alignment: .center, spacing: 5) {
            TextField(
                "оставь свой отзыв",
                text: $desc,
                axis: .vertical
            )
            .focused($isFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(10)
            .lineLimit(10...20)
            .overlay(
                RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                    .stroke(
                        isFocused ? Static.Colors.accent : .black
                    )
            )
            
        }
    }
    
    private var createButton: some View {
        MainButton(model: .text("Сохранить"), style: .accentFilled, action: {
            dismiss()
        })
    }
    
    @ObservedObject private var model: Model
    @State private var desc: String = ""
    @FocusState private var isFocused: Bool
    
}

private enum Static {
    
    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }
    
    enum Symbols {
        static let star: Image = Image(systemName: "star.fill")
        static let starStroked: Image = Image(systemName: "star")
        static let link: Image = Image(systemName: "link")
        static let heart: Image = Image(systemName: "heart")
        static let heartFilled: Image = Image(systemName: "heart.fill")
    }
    
}

#Preview {
    CreateReviewView(model: CreateReviewViewModelImpl())
}
