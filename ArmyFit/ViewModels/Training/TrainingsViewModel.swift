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
    private let service: TrainingHoursService
    private var trainingUser: [TrainingUser] = []
    var trainingUserSections: [TrainingUserSection] = []
    
    //MARK: - Public properties
    var delegate: TrainingViewModelDelegate?
    var crossfit: String?
    
    init(service: TrainingHoursService = .init()) {
        self.service = service
    }
    
    //MARK: - Public methods
    func fetchTrainingUser(_ date: String) {
        service.getTrainingUser(date) { success, error in
            guard let success = success else { return }
            
            self.trainingUser = success
            self.organizeSections(trainings: success)
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
    
    private func organizeSections(trainings: [TrainingUser]) {
        trainings.forEach { training in
            let section = trainingUserSections.first(where: { section in
                return section.name == training.training_hours?.training.name
            })
            
            if let section = section {
                section.trainings.append(training)
            } else {
                let section = TrainingUserSection(name: training.training_hours?.training.name ?? "", trainings: [training])
                trainingUserSections.append(section)
            }
        }
    }
    
}
