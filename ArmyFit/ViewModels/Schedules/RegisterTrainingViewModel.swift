//
//  RegisterTrainingViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 19/06/22.
//

import Foundation

class RegisterTrainingViewModel {
    
    //MARK: - Private propertie
    private let trainingDetail: TrainingHours
    
    init(trainingDetail: TrainingHours) {
        self.trainingDetail = trainingDetail
    }
    
    //MARK: - Public methods
    func getUserImage(_ index: Int) -> String {
        guard let user = trainingDetail.trainingUsers,
                let image = user[index].user?.photoUrl else { return "profile"}
        return image
    }
    
    func getUserName(_ index: Int) -> String {
        guard let user = trainingDetail.trainingUsers,
              let name = user[index].user?.name else { return "Usuario sem nome"}
        return name
    }
}
