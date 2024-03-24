//
//  File.swift
//
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import Foundation

public struct CreateReviewViewState {
    static var initial = CreateReviewViewState()
}

@MainActor
public protocol CreateReviewViewModel: ObservableObject {
    func onViewAppear()
    func onLoginTap()
    func onViewDisappear()
}

@MainActor
public final class CreateReviewViewModelImpl: CreateReviewViewModel {

    @Published private(set) public var viewState: CreateReviewViewState = .initial

    public init() {
        self.viewState = CreateReviewViewState()
    }

    public func onViewAppear() {
    }

    public func onLoginTap() {
    }

    public func onViewDisappear() {
    }
}
