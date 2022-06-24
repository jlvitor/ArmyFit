//
//  TrainingViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 23/06/22.
//

import Foundation

class TrainingViewModel {
    
    //MARK: - Private methods
    private let service: UserService
    private var trainingDetail: TrainingUser
    
    init(service: UserService = .init(), trainingDetail: TrainingUser) {
        self.service = service
        self.trainingDetail = trainingDetail
    }

    //MARK: - Getters
    var getExerciseName: String {
        guard let exerciseName = trainingDetail.training_hours?.training.name else {
            return "Não foi possivel carregar o aviso desse treino"
        }
        return exerciseName
    }
    
    var getWarning: String {
        guard let warning = trainingDetail.training_hours?.training.warning else {
            return "Não foi possivel carregar o aviso desse treino"
        }
        return warning
    }
    
    var getDetail: String {
        guard let detail = trainingDetail.training_hours?.description else {
            return "Não foi possivel carregar o aviso desse treino"
        }
        return detail
    }
}