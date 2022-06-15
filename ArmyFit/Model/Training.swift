//
//  Trainings.swift
//  ArmyFit
//
//  Created by Marcelo Falcao Costa Filho on 30/05/22.
//

import Foundation

struct Training: Codable {
    let id: String // Id do treino
    let name: String // Nome do treino (crossfit)
    let created_at: String // Quando foi criado/ ou inserido o treino no banco de dados
    let warning: String // Aviso antes de iniciar o treino
    var trainingHours: [TrainingHours]? // Array com horários e dados de um treino específico
}

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

struct TrainingUser: Codable {
    let id: String // Id de cada usuario no treino
    let user: User? // Dados de um usuario em específico
    let user_id: String // Id do usuario ( relacao com id na struct User)
    let training_hours: TrainingHours? // Dados de um horário específico
    let trainingHoursId: String //Id do horario de um treino específico (relacao com id na struct TrainingHours)
}
