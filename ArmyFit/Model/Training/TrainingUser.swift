//
//  TrainingUser.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 21/06/22.
//

import Foundation

struct TrainingUser: Codable {
    let id: String // Id de cada usuario no treino
    let user: User? // Dados de um usuario em específico
    let user_id: String // Id do usuario ( relacao com id na struct User)
    let training_hours: TrainingHours? // Dados de um horário específico
    let training_hours_id: String //Id do horario de um treino específico (relacao com id na struct TrainingHours)
}
