//
//  UserData.swift
//  UsersAC
//
//  Created by Amanda Rosa on 2023-03-06.
//

import Foundation

public struct User: Codable, Equatable, Hashable {
    
    public let avatar: String
    public let name: String
    public let profile: Profile
    public let id: Int?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        avatar = try container.decode(String.self, forKey: .avatar)
        name = try container.decode(String.self, forKey: .name)
        profile = try container.decode(Profile.self, forKey: .profile)
        do {
            id = try container.decode(Int.self, forKey: .id)
        } catch DecodingError.typeMismatch {
            id = try Int(container.decode(String.self, forKey: .id))
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(name)
    }
    
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
    }
}

public struct Profile: Codable {
    
    public let firstName: String
    public let lastName: String
}
