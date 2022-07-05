//
//  TrainingViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 07/06/22.
//

import Foundation

class ScheduleViewModel {
    
    //MARK: - Private propertie
    private let trainingHours: TrainingHoursDTO
    
    init(_ trainingHours: TrainingHoursDTO) {
        self.trainingHours = trainingHours
    }
    
    //MARK: - Getters
    var getHourTraining: String {
        Date.formatDateStringToHour(date: trainingHours.dateHour)
    }
    
    var getMinuteTraining: String {
        Date.formatDateStringToMinute(date: trainingHours.dateHour)
    }
    
    var getTrainingName: String {
        trainingHours.training.name.uppercased()
    }
    
    var getCoachName: String {
        trainingHours.instructor.uppercased()
    }
    
    var getAvailableSpots: String {
        "\(trainingHours.availableSpots)"
    }
    
    var getSpots: String {
        "\(trainingHours.spots)"
    }
}
