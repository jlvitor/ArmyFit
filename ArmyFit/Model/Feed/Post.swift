//
//  Post.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 16/06/22.
//

import Foundation

struct Post: Codable {
    let id: String
    let description: String
    let like: Int
    let user_id: String
    let created_at: String
    let user: User
    let feed_comments: [CommentPost]?
}




