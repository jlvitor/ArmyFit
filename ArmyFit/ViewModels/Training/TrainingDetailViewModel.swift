//
//  TrainingDetailViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 22/06/22.
//

import Foundation

class TrainingDetailViewModel {
    
    private let trainingDetail: TrainingUser
    
    init(_ trainingDetail: TrainingUser) {
        self.trainingDetail = trainingDetail
    }
    
    func getHourTraining() -> String {
        guard let trainingHour = trainingDetail.trainingHours?.dateHour else { return "" }
        return Date.formatDateStringToHour(date: trainingHour)
    }
    
    func getMinuteTraining() -> String {
        guard let trainingMinute = trainingDetail.trainingHours?.dateHour else { return "" }
        return Date.formatDateStringToMinute(date: trainingMinute)
    }
    
    func getCoachName() -> String {
        guard let coachName = trainingDetail.trainingHours?.instructor else { return "" }
        let name = convertToUppercasedFrom(coachName)
        return name
    }
    
    private func convertToUppercasedFrom(_ text: String) -> String {
        return text.uppercased()
    }
    
}
