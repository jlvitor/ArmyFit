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
    var trainings: [TrainingUser] = []
    
    init(name: String, trainings: [TrainingUser]) {
        self.name = name
        self.trainings = trainings
    }
}
