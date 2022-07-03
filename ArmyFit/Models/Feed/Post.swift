//
//  Post.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 16/06/22.
//

import Foundation

struct Post: Decodable {
    let id: String
    let description: String
    let like: Int
    let userId: String
    let createdAt: String
    let user: User
    let feedComments: [CommentPost]?
    
    enum CodingKeys: String, CodingKey {
        case id, description, like
        case userId = "user_id"
        case createdAt = "created_at"
        case user
        case feedComments = "feed_comments"
    }
}




