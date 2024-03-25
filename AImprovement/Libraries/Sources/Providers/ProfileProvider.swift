import Foundation
import Types

public protocol ProfileProvider {
    func getProfiles() -> [Types.Profile]
    func updateDescription(id: Int, desc: String)
}

public final class ProfileProviderImpl: ProfileProvider {
    public init() { }
    public func getProfiles() -> [Types.Profile] {
        return profiles
    }

    private var profiles: [Types.Profile] = [
        Types.Profile(id: 0, nick: "Алиса Вышегородцева", email: "a.g.vyshegorodtseva@tinkoff.ru", description: ""),
        Types.Profile(id: 1, nick: "Яна Барбашина", email: "yanawishnya@yandex-team.ru", description: "Яндекс")
    ]
    
    public func updateDescription(id: Int, desc: String) {
        profiles[id].description = desc
    }
}
