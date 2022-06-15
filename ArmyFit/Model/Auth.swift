//
//  Auth.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 13/06/22.
//

import Foundation

struct Auth: Codable {
    let token: String
    let user: UserResponse
}

struct UserResponse: Codable {
    let id: String
    let name: String
    let email: String
    let photoUrl: String
}
