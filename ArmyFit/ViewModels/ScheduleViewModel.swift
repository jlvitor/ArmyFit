//
//  TrainingViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 07/06/22.
//

import Foundation

class ScheduleViewModel {
    
    private let trainingHours: TrainingHours
    
    init(_ trainingHours: TrainingHours) {
        self.trainingHours = trainingHours
    }
    
    func getHourTraining() -> String {
        let trainingHour = trainingHours.date_hour
        return Date.formatDateStringToHour(date: trainingHour)
    }
    
    func getMinuteTraining() -> String {
        let trainingMinute = trainingHours.date_hour
        return Date.formatDateStringToMinute(date: trainingMinute)
    }
    
    func getTrainingName() -> String {
        let trainingName = trainingHours.training.name
        let title = convertToUppercasedFrom(trainingName)
        return title
    }
    
    func getCoachName() -> String {
        let coachName = trainingHours.instructor
        let name = convertToUppercasedFrom(coachName)
        return name
    }
    
    func getAvailableSpots() -> String {
        let availableSpots = trainingHours.available_spots
        return "\(availableSpots)"
    }
    
    func getSpots() -> String {
        let spots = trainingHours.spots
        return "\(spots)"
    }
    
    private func convertToUppercasedFrom(_ text: String) -> String {
        return text.uppercased()
    }
}
