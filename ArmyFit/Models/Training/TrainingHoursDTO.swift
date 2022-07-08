//
//  TrainingHours.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 21/06/22.
//

import Foundation

struct TrainingHoursDTO: Decodable {
    let id: String
    let dateHour: String
    let spots: Int
    let availableSpots: Int
    let instructor: String
    let description: String
    let training: TrainingDTO
    let trainingId: String?
    let trainingUsers: [TrainingUserDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case dateHour = "date_hour"
        case spots
        case availableSpots = "available_spots"
        case instructor, description, training
        case trainingId = "training_id"
        case trainingUsers = "training_users"
    }
}
