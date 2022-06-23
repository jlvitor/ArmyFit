//
//  TrainingsViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 08/06/22.
//

import Foundation

protocol TrainingViewModelDelegate {
    func reloadData()
}

class TrainingsViewModel {
    
    private let service: TrainingHoursService = .init()
    private var trainingUser: [TrainingUser] = []
    
    var delegate: TrainingViewModelDelegate?
    var trainingCount: Int = 0
    
    func fetchTrainingUser(_ date: String) {
        service.getTrainingUser(date) { success, error in
            guard let success = success else { return }
            self.trainingUser = success
            self.trainingCount = success.count
            self.delegate?.reloadData()
        }
    }
    
    func getTrainingCellViewModel(_ index: Int) -> TrainingDetailViewModel {
        let training = trainingUser[index]
        return TrainingDetailViewModel(training)
    }
    
    func getTrainingDetail(at index: Int?) -> TrainingViewModel? {
        guard let index = index else { return nil }

        let detail = trainingUser[index]
        return TrainingViewModel(trainingDetail: detail)
    }
    
}
