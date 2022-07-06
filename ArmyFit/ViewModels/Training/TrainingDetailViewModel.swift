//
//  TrainingDetailViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 22/06/22.
//

import Foundation

class TrainingDetailViewModel {
    
    //MARK: - Private propertie
    private let trainingDetail: TrainingUserDTO
    
    init(_ trainingDetail: TrainingUserDTO) {
        self.trainingDetail = trainingDetail
    }
    
    //MARK: - Getters
    var getHourTraining: String {
        Date.formatDateStringToHour(date: trainingDetail.trainingHours?.dateHour ?? "")
    }
    
    var getMinuteTraining: String {
        Date.formatDateStringToMinute(date: trainingDetail.trainingHours?.dateHour ?? "")
    }
    
    var getCoachName: String {
        trainingDetail.trainingHours?.instructor.uppercased() ?? ""
    }
}
