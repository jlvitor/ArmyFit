//
//  UserResponse.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 21/06/22.
//

import Foundation

struct UserResponse: Codable {
    let id: String
    let name: String
    let email: String
    let photoUrl: String?
}
