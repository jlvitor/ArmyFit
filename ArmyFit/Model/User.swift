//
//  User.swift
//  ArmyFit
//
//  Created by Marcelo Falcao Costa Filho on 30/05/22.
//

import Foundation

struct User: Codable {
    let id: UUID // Id do usuário
    let name: String // Nome do usuário
    let email: String // Email do usuário
    let password: String // Senha do usuário
    let photoURL: String? // Imagem do usuário
    var trainingUser: [TrainingUser]? // Array de treinos que o usuário se inscreveu
}
