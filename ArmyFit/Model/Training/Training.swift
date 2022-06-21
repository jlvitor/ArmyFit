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
