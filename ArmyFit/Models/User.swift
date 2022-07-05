//
//  User.swift
//  ArmyFit
//
//  Created by Marcelo Falcao Costa Filho on 30/05/22.
//

import Foundation

struct User: Decodable {
    let id: String
    let name: String
    let email: String
    let password: String
    let photoUrl: String?
    var trainingUser: [TrainingUserDTO]?
}
