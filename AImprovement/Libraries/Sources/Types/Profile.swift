import SwiftUI


public struct Profile: Identifiable, Hashable {
    
    public init(
        id: Int,
        nick: String,
        email: String,
        description: String
    ) {
        self.id = id
        self.nick = nick
        self.email = email
        self.description = description
    }

    public var id: Int
    public var nick: String
    public var email: String
    public var description: String

}
