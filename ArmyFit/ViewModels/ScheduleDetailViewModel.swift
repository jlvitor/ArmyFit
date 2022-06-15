//
//  TrainingDetailViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 08/06/22.
//

import Foundation

class ScheduleDetailViewModel {
    private let hourDetail: TrainingHours
    
    init(_ hourDetail: TrainingHours) {
        self.hourDetail = hourDetail
    }
    
    func getHourTraining() -> String {
        let trainingHour = hourDetail.date_hour
        return Date.formatDateStringToHour(date: trainingHour)
    }
    
    func getMinuteTraining() -> String {
        let trainingMinute = hourDetail.date_hour
        return Date.formatDateStringToMinute(date: trainingMinute)
    }
    
    func getCoachName() -> String {
        let coachName = hourDetail.instructor
        let name = convertToUppercasedFrom(coachName)
        return name
    }
    
    func getAvailableSpots() -> String {
        let availableSpots = hourDetail.available_spots
        return "\(availableSpots)"
    }
    
    func getSpots() -> String {
        let spots = hourDetail.spots
        return "\(spots)"
    }
    
    func getNumberOfUsers() -> Int {
        guard let users = hourDetail.training_users?.count else { return 0}
        return users
    }
    
    func getUserImage() -> String {
        guard let userImage = hourDetail.training_users,
              let image = userImage[0].user?.photoURL else { return "person.fill" }
        return image
    }
    
    func getUserName() -> String {
        guard let userName = hourDetail.training_users,
              let name = userName[0].user?.name else { return "Usuário sem nome"}
        return name
    }
    
    private func convertToUppercasedFrom(_ text: String) -> String {
        return text.uppercased()
    }
}
