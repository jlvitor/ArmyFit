//
//  TrainingUser.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 21/06/22.
//

import Foundation

struct TrainingUserDTO: Decodable {
    let id: String
    let user: UserDTO?
    let userId: String
    let trainingHours: TrainingHoursDTO?
    let trainingHoursId: String
    
    enum CodingKeys: String, CodingKey {
        case id, user
        case userId = "user_id"
        case trainingHours = "training_hours"
        case trainingHoursId = "training_hours_id"
    }
}
