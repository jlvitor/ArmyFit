//
//  DayViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 08/06/22.
//

import Foundation

class DayViewModel {
    
    //MARK: - Private propertie
    private var trainingDay: (String, String)
    
    init(trainingDay: (String, String)) {
        self.trainingDay = trainingDay
    }
    
    //MARK: - Getters
    var getDayStringInAMonth: String {
        convertToUppercasedAndRemoveDotIfNecessary(trainingDay.1)
    }
    
    var getDayIntInAMonth: String {
        trainingDay.0
    }
    
    //MARK: - Private methods
    private func convertToUppercasedAndRemoveDotIfNecessary(_ text: String) -> String {
        var dayName = text
        
        if dayName.contains(".") {
            dayName.removeLast()
            return dayName.uppercased()
        }
        return dayName.uppercased()
    }
}
