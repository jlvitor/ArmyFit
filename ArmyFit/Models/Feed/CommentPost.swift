//
//  CommentPost.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 21/06/22.
//

import Foundation

struct CommentPost: Decodable {
    let id: String
    let comment: String
    let feedsId: String
    let usersId: String
    let createdAt: String
    let user: UserDTO
    
    enum CodingKeys: String, CodingKey {
        case id, comment, feedsId, usersId
        case createdAt = "created_at"
        case user
    }
}
