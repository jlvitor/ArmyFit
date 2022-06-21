//
//  CommentPost.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 21/06/22.
//

import Foundation

struct CommentPost: Codable {
    let id: String
    let comment: String
    let feedsId: String
    let usersId: String
    let created_at: String
    let user: User
}
