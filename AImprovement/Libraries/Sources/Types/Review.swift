import SwiftUI

public struct Review: Identifiable, Hashable {

    public init(
        id: Int,
        author: Types.Profile,
        text: String,
        stars: Int

    ) {
        self.id = id
        self.author = author
        self.text = text
        self.stars = stars

    }

    public var id: Int
    public var author: Types.Profile
    public var text: String
    public var stars: Int

}
