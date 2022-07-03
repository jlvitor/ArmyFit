//
//  TrainingUser.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 21/06/22.
//

import Foundation

struct TrainingUser: Decodable {
    let id: String
    let user: User?
    let userId: String
    let trainingHours: TrainingHours?
    let trainingHoursId: String
    
    enum CodingKeys: String, CodingKey {
        case id, user
        case userId = "user_id"
        case trainingHours = "training_hours"
        case trainingHoursId = "training_hours_id"
    }
}
