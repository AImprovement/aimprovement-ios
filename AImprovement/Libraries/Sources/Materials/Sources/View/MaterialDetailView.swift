//
//  SwiftUIView.swift
//
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import SwiftUI
import UIComponents
import Providers
import Types


public struct MaterialDetailView: View {
    private let material: Types.Material
    @State private var isPresented: Bool = false
    @State private var showingSheet: Bool = false
    @State private var loading: Bool = true

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(material: Types.Material) {
        self.material = material
    }
    
    public var body: some View {
        VStack() {
            CustomNavBar(onBack: {
                presentationMode.wrappedValue.dismiss()
            })
            if loading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading,spacing: 5){
                        headline
                            .padding(.top, 17)
                        author
                        description
                        link
                            .padding(.top)
                        rating
                            .padding(.top)
                        Text("Отзывы пользователей")
                            .font(Fonts.subText)
                            .bold()
                        review
                    }
                }
                .scrollClipDisabled()
                .scrollIndicators(.hidden)
                createButton
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.loading.toggle()
            }
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .navigationBarBackButtonHidden()
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
    }
    
    private var createButton: some View {
        MainButton(model: .text("Написать отзыв"), style: .accentFilled, action: {
            showingSheet.toggle()
        })
        .sheet(isPresented: $showingSheet){
            CreateReviewView(model: CreateReviewViewModelImpl())
        }
    }
    
    private var headline: some View {
        Text(material.title)
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var author: some View {
        Text(material.author)
            .font(Fonts.subText)
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var description: some View {
        Text(material.description)
            .font(Fonts.subText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    public func getMeanReviews() -> CGFloat {
        var sumArray: CGFloat = 0
        material.reviews.forEach { review in
            sumArray += CGFloat(review.stars)
        }
        let avgArrayValue = CGFloat(sumArray) / CGFloat(material.reviews.count)
        return avgArrayValue
    }
    
    private var rating: some View {
        HStack {
            Static.Symbols.star
                .renderingMode(.template)
                .foregroundStyle(Static.Colors.accent)
                .frame(width: 15, height: 15)
            Text(getMeanReviews().description)
                .foregroundStyle(.black)
                .font(Fonts.subText)
            Text("\(material.reviews.count.description) отзыва")
                .foregroundStyle(.black)
                .font(Fonts.subText)
        }
    }
    
    public var link: some View {
        Link(destination: material.link) {
            ZStack {
                HStack(spacing:3) {
                    Static.Symbols.link
                    Text(material.site)
                        .font(Fonts.subText)
                    Text(material.price)
                        .font(Fonts.subText)
                }
                .foregroundColor(Static.Colors.accent)
                .padding(10)
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Static.Colors.accent)
            }
        }
    }
    
    public var review: some View {
        VStack(spacing: 19) {
            ForEach(Array(material.reviews.enumerated()), id: \.1.id) { ind, review in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(.profile)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .symbolRenderingMode(.monochrome)
                            .foregroundColor(.black)
                        VStack(alignment: .leading) {
                            Text(review.author.nick)
                                .font(Fonts.subText)
                            Text(review.author.email)
                                .font(Fonts.subText)
                                .foregroundStyle(.gray)
                        }
                    }
                    stars(count: review.stars)
                    Text(review.text)
                        .font(Fonts.subText)
                        .foregroundStyle(.black)
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black)
                }
            }
        }
    }
    
    public func stars(count: Int) -> some View {
        HStack {
            ForEach(0..<count) { i in
                Static.Symbols.star
            }
        }
        .foregroundStyle(Static.Colors.accent)
    }
    
}

private enum Static {
    
    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }
    
    enum Symbols {
        static let star: Image = Image(systemName: "star.fill")
        static let link: Image = Image(systemName: "link")
        static let heart: Image = Image(systemName: "heart")
        static let heartFilled: Image = Image(systemName: "heart.fill")
    }
    
}

//#Preview {
//    MaterialDetailView(material: MaterialDetailViewModelImpl())
//}
