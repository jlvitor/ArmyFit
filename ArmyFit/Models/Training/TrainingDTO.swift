//
//  Trainings.swift
//  ArmyFit
//
//  Created by Marcelo Falcao Costa Filho on 30/05/22.
//

import Foundation

struct TrainingDTO: Decodable {
    let id: String
    let name: String
    let createdAt: String
    let warning: String
    var trainingHours: [TrainingHoursDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case warning, trainingHours
    }
}
