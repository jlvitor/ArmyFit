//
//  User.swift
//  ArmyFit
//
//  Created by Marcelo Falcao Costa Filho on 30/05/22.
//

import Foundation

struct User: Codable {
    let id: String // Id do usuário
    let name: String // Nome do usuário
    let email: String // Email do usuário
    let password: String // Senha do usuário
    let photoUrl: String? // Imagem do usuário
    var trainingUser: [TrainingUser]? // Array de treinos que o usuário se inscreveu
}
