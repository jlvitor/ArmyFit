//
//  Trainings.swift
//  ArmyFit
//
//  Created by Marcelo Falcao Costa Filho on 30/05/22.
//

import Foundation

struct Training: Codable {
    let id: UUID // Id do treino
    let name: String // Nome do treino
    let created_at: Date // Quando foi criado/ ou inserido o treino no banco de dados
    var trainingHours: [TrainingHours]? // Array com horários e dados de um treino específico
}

struct TrainingHours: Codable {
    let id: UUID // Id do horário do treino
    let date_hour: Date // Dia e horário do treino
    let spots: Int // Vagas do treino
    var availabe_spots: Int // Vagas restantes/ disponiveis do treino
    let instructor: String // Instrutor/ professor do treino
    let description: String // Descricao do treino
    let warning: String // Aviso antes de iniciar o treino
    let training: Training // Dados de um treino específico
    let training_id: UUID? // Id do treino (relacao com id na struct Training)
    let training_users: [TrainingUser] // Array de
}

struct TrainingUser: Codable {
    let id: UUID // Id de cada usuario no treino
    let user: User // Dados de um usuario em específico
    let user_id: UUID? // Id do usuario ( relacao com id na struct User)
    let training_hours: TrainingHours? // Dados de um horário específico
    let training_hoursId: UUID //Id do horario de um treino específico (relacao com id na struct TrainingHours)
}
