//
//  RegisterTrainingViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 19/06/22.
//

import Foundation

class RegisterTrainingViewModel {
    
    private let trainingDetail: TrainingHours
    
    init(trainingDetail: TrainingHours) {
        self.trainingDetail = trainingDetail
    }
    
    func getUserImage(_ index: Int) -> String {
        guard let user = trainingDetail.training_users,
                let image = user[index].user?.photoUrl else { return ""}
        return image
    }
    
    func getUserName(_ index: Int) -> String {
        guard let user = trainingDetail.training_users,
              let name = user[index].user?.name else { return "Usuario sem nome"}
        return name
    }
}
