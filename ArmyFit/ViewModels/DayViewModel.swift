//
//  DayViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 08/06/22.
//

import Foundation

class DayViewModel {
    
    private var trainingDay: (String, String)
    
    init(trainingDay: (String, String)) {
        self.trainingDay = trainingDay
    }
    
    func getDayStringInAMonth() -> String {
        let dayName = trainingDay.1
        return convertToUppercasedAndRemoveDotIfNecessary(dayName)
    }

    func getDayIntInAMonth() -> String {
        let day = trainingDay.0
        return day
    }
    
    private func convertToUppercasedAndRemoveDotIfNecessary(_ text: String) -> String {
        var dayName = text
        
        if dayName.contains(".") {
            dayName.removeLast()
            return dayName.uppercased()
        }
        return dayName.uppercased()
    }
}
