//
//  TrainingUserSection.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 23/06/22.
//

import Foundation

class TrainingUserSection {
    
    //MARK: - Public properties
    var name: String
    var trainings: [TrainingUserDTO] = []
    
    init(name: String, trainings: [TrainingUserDTO]) {
        self.name = name
        self.trainings = trainings
    }
}
