import SwiftUI

public struct Message: Identifiable, Hashable {

    public enum MessageType: Hashable {
        case text(String)
        case material(Types.Material)
    }

    public enum Icon: String {
        case user = "quote.opening"
        case app

        public var image: Image {
            switch self {
            case .user:
                return Image(systemName: rawValue)
            case .app:
                return Image("Profile", bundle: .module)
            }
        }
    }

    public init(type: Message.MessageType) {
        self.id = .random(in: 0...1000)
        self.type = type
        self.fromUser = false
        self.icon = nil
    }

    public init(id: Int, type: Message.MessageType, fromUser: Bool, shouldShowIcon: Bool) {
        self.id = id
        self.type = type
        self.fromUser = fromUser
        self.icon = shouldShowIcon ? (fromUser ? .user : .app) : nil
    }

    public let id: Int
    public let type: Message.MessageType
    public let fromUser: Bool
    public let icon: Message.Icon?

}
