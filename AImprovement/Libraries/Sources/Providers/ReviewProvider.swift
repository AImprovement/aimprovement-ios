import Foundation
import Types

public protocol ReviewProvider {
    func getReviews() -> [Types.Review]
}

public final class ReviewProviderImpl: ReviewProvider {
    public init() { }
    public func getReviews() -> [Types.Review] {
        return reviews
    }

    private var reviews: [Types.Review] = [
        Types.Review(id: 0, author: ProfileProviderImpl().getProfiles()[0], text: "Мне понравились некоторые инсайты этой книги, извлекла для себя много полезного", stars: 5),
        Types.Review(id: 1, author: ProfileProviderImpl().getProfiles()[1], text: "Немного не хватило чего-то. В целом полезная вещь, но для меня было мало новой информации", stars: 4),
    ]
}
