//
//  LikePost.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 21/06/22.
//

import Foundation

struct LikePost: Codable {
    let id: String
    let description: String
    let like: Int
    let user_id: String
    let created_at: String
}
