//
//  File.swift
//
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import Foundation
import Types
import SwiftUI

public struct MaterialDetailViewState {
    static var initial = MaterialDetailViewState()
}

@MainActor
public protocol MaterialDetailViewModel: ObservableObject {
    func onViewAppear()
    func onViewDisappear()
}

@MainActor
public final class MaterialDetailViewModelImpl: MaterialDetailViewModel {

    @Published private(set) public var viewState: MaterialDetailViewState = .initial

    public init() {
        self.viewState = MaterialDetailViewState()
    }
    

    public func onViewAppear() {
    }

    public func onViewDisappear() {
    }
}
