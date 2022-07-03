//
//  TrainingHours.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 21/06/22.
//

import Foundation

struct TrainingHours: Codable {
    let id: String // Id do horário do treino
    let date_hour: String // Dia e horário do treino
    let spots: Int // Quantidade de usuarios que se cadastraram no treino
    let available_spots: Int // Vagas disponiveis
    let instructor: String // Instrutor/ professor do treino
    let description: String // Descricao do treino
    let training: Training // Dados de um treino específico
    let training_id: String? // Id do treino (relacao com id na struct Training)
    let training_users: [TrainingUser]? // Array de usuarios cadastrados no treino
}
