//
//  TrainingsViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 07/06/22.
//

import Foundation
import UIKit

protocol SchedulesViewModelDelegate {
    func reloadData()
}

class SchedulesViewModel {
    
    private let service: TrainingHoursService = .init()
    private var trainingHoursList: [TrainingHours] = []
    
    var delegate: SchedulesViewModelDelegate?
    var trainingHoursCount: Int = 0
    var trainingDays: [(String, String)] = []
    var cellSelected: Int = 0
    var date: String? = Date.getCurrentDateToDateString()
    
    func fetchTrainingsHours(_ date: String) {
        service.getAllTrainingHours(date) { success, error in
            guard let success = success else {
                return
            }
            
            self.trainingHoursCount = success.count
            self.trainingHoursList = self.sortedDate(success)
            self.delegate?.reloadData()
        }
    }
    
    func getTrainingCellViewModel(_ index: Int) -> ScheduleViewModel {
        let training = trainingHoursList[index]
        return ScheduleViewModel(training)
    }
    
    func getDayCellViewModel(_ index: Int) -> DayViewModel {
        let daysSorted = trainingDays.sorted {$0.0 < $1.0 }
        let day = daysSorted[index]
        return DayViewModel(trainingDay: day)
    }
    
    func getTrainingHoursDetail(_ index: Int?) -> ScheduleDetailViewModel? {
        guard let index = index else { return nil }
        
        let trainingHoursId = trainingHoursList[index].id
        return ScheduleDetailViewModel(trainingHoursId)
    }
    
    func configCellBackgroundColorWhenSelected(_ cell: DateCollectionViewCell?, at index: Int) {
        if index == cellSelected {
            cell?.backgroundColor = UIColor(named: "green_color")
        } else {
            cell?.backgroundColor = UIColor(named: "dark_background")
        }
    }
    
    func getRemainingDaysInAMonth() {
        let currentDate = Date() // Tras a data atual
        let dateFormatter = DateFormatter() // Formatador de data
        let calendar = Calendar.current // Componente de calendario
        let year = calendar.component(.year, from: currentDate) // Retornao o ano atual do dispositivo
        let month = calendar.component(.month, from: currentDate) // Retorna o mes atual do dispositivo
        let currentDay = calendar.component(.day, from: currentDate)
        
        // Retorna um range de dias do mes atual do dispositivo
        let range = calendar.range(of: .day, in: .month, for: currentDate)
        
        range?.forEach({ day in
            // Formata a data no padrao ano/mes/dia - ISO
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: "\(year)/\(month)/\(day)") {
                if day >= currentDay {
                    dateFormatter.dateFormat = "EEE"
                    let dayName = dateFormatter.string(from: date)
                    let dayFormatted = String(format: "%02d", day)
                    trainingDays.append((dayFormatted, dayName))
                }
            }
        })
    }
    
    func getDayStringToDateString(day: String) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let monthFormatted = String(format: "%02d", month)
        
        let dateFormatted = String("\(year)-\(monthFormatted)-\(day)")
        return dateFormatted
    }
    
    private func sortedDate(_ hours: [TrainingHours]) -> [TrainingHours] {
        let dateFormatter = DateFormatter()
        
        let hours = hours.sorted(by: { firstDate, secondDate in
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let saveFirstDate = dateFormatter.date(from: firstDate.date_hour)
            let saveSecondDate = dateFormatter.date(from: secondDate.date_hour)
            
            guard let saveFirstDate = saveFirstDate,
                  let saveSecondDate = saveSecondDate else { return false }
            return saveFirstDate < saveSecondDate
        })
        return hours
    }
}
