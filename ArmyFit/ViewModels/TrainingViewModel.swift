//
//  TrainingViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 08/06/22.
//

import Foundation

class TrainingViewModel {
    
    private let trainingDetail: TrainingHours
    
    init(trainingDetail: TrainingHours){
        self.trainingDetail = trainingDetail
    }
    
    func setTraining(at section: Int, at row: Int) -> TrainingCellViewModel {
        switch section {
        case 0:
            return TrainingCellViewModel(text: getWarning())
        default:
            return TrainingCellViewModel(text: getDetail())
        }
    }
    
    func countRowsInSection(_ section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    
    func setTitleForSection(_ section: Int) -> String? {
        switch section {
        case 0:
            return "Avisos"
        default:
            return "Treino"
        }
    }
    
    private func getWarning() -> String {
        let warning = trainingDetail.training.warning
        return warning
    }
    
    private func getDetail() -> String {
        let detail = trainingDetail.description
        return detail
    }
}
