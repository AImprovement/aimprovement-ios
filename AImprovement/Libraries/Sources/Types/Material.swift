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
        link: URL,
        price: String,
        site: String,
        reviews: [Types.Review]
    ) {
        self.id = id
        self.author = author
        self.title = title
        self.description = description
        self.icon = icon
        self.isLiked = isLiked
        self.link = link
        self.price = price
        self.site = site
        self.reviews = reviews
        self.ratingCount = reviews.count
        getMeanReviews()
    }

    public let id: Int
    public let author: String
    public let title: String
    public let description: String
    public let icon: Material.Icon
    public var isLiked: Bool
    public var rating: Int?
    public var ratingCount: Int
    public let link: URL
    public let price: String
    public let site: String
    public var reviews: [Types.Review]

    public mutating func getMeanReviews() {
        guard !reviews.isEmpty else {
            self.rating = 0
            return
        }
        var sumArray: Double = 0
        reviews.forEach { review in
            sumArray += Double(review.stars)
        }
        let avgArrayValue = Double(sumArray) / Double(reviews.count)
        self.rating = Int(avgArrayValue)
    }

}
