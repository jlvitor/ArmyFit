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
    
    //MARK: - Private properties
    private let service: TrainingHoursService = .init()
    private var trainingUserList: [TrainingUser] = []
    
    //MARK: - Public properties
    var delegate: TrainingViewModelDelegate?
    var trainingUserSections: [TrainingUserSection] = []
    
    //MARK: - Public methods
    func fetchTrainingUser(_ date: String) {
        service.getTrainingUser(date) { trainingUsers, error in
            guard let trainingUsers = trainingUsers else { return }
            
            self.trainingUserList = trainingUsers
            self.organizeSections(trainings: trainingUsers)
            self.delegate?.reloadData()
        }
    }
    
    func getTrainingCellViewModel(_ section: Int, _ index: Int) -> TrainingDetailViewModel {
        let training = trainingUserSections[section].trainings[index]
        return TrainingDetailViewModel(training)
    }
    
    func getTrainingDetail(_ section: Int?, _ index: Int?) -> TrainingViewModel? {
        guard let section = section,
              let index = index else { return nil }

        let detail = trainingUserSections[section].trainings[index]
        return TrainingViewModel(trainingDetail: detail)
    }
    
    //MARK: - Private method
    private func organizeSections(trainings: [TrainingUser]) {
        trainings.forEach { training in
            let section = trainingUserSections.first(where: { section in
                return section.name == training.trainingHours?.training.name
            })
            
            if let section = section {
                section.trainings.append(training)
            } else {
                let section = TrainingUserSection(name: training.trainingHours?.training.name ?? "", trainings: [training])
                trainingUserSections.append(section)
            }
        }
    }
    
}
