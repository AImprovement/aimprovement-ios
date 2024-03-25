import Foundation
import Types

public protocol ProfileProvider {
    func getProfiles() -> [Types.Profile]
}

public final class ProfileProviderImpl: ProfileProvider {
    public init() { }
    public func getProfiles() -> [Types.Profile] {
        return profiles
    }

    private var profiles: [Types.Profile] = [
        Types.Profile(id: 0, nick: "Алиса Вышегородцева", email: "a.g.vyshegorodtseva@tinkoff.ru", description: "Тинькофф Банк")
    ]
}
