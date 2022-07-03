//
//  Auth.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 13/06/22.
//

import Foundation

struct Auth: Decodable {
    let token: String
    let user: UserResponse
}


