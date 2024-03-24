import SwiftUI

public struct Material: Identifiable, Hashable {

    public enum Icon: String {
        case book
        case course = "play.desktopcomputer"
        case unknown = "info.circle"

        public var image: Image {
            return Image(systemName: rawValue)
        }
    }

    public init(
        id: Int,
        author: String,
        title: String,
        description: String,
        icon: Material.Icon,
        isLiked: Bool,
        rating: Double,
        ratingCount: String,
        link: URL,
        price: String,
        site: String
    ) {
        self.id = id
        self.author = author
        self.title = title
        self.description = description
        self.icon = icon
        self.isLiked = isLiked
        self.rating = rating
        self.ratingCount = ratingCount
        self.link = link
        self.price = price
        self.site = site
    }

    public var id: Int
    public var author: String
    public let title: String
    public let description: String
    public let icon: Material.Icon
    public var isLiked: Bool
    public let rating: Double
    public let ratingCount: String
    public let link: URL
    public let price: String
    public let site: String

    public mutating func updateLike() {
        isLiked.toggle()
    }

}
