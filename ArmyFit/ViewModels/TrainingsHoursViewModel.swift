//
//  TrainingsViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 07/06/22.
//

import Foundation

class TrainingsHoursViewModel {
    
    private let service: TrainingHoursService = TrainingHoursService()
    private var trainingHoursList: [TrainingHours] = []
    private var trainingHoursDateList: [TrainingHours] = []
    
    var trainingHoursCount: Int = 0
    var trainingDays: [String: String] = [:]
    
    func fetchTrainingsHours() {
        service.getTrainingHoursFromJson(fromFileNamed: "trainingHours") { success, error in
            guard let success = success else { return }
            self.trainingHoursList = self.sortedDate(success)
            self.trainingHoursDateList = success
            self.trainingHoursCount = success.count
        }
    }
    
    func getTrainingCellViewModel(_ index: Int) -> TrainingHoursViewModel {
        let training = trainingHoursList[index]
        return TrainingHoursViewModel(training)
    }
    
    func getDayCellViewModel(_ index: Int) -> DayViewModel {
        let daysInArray = Array(trainingDays).sorted {$0.0 < $1.0 }
        let day = daysInArray[index]
        return DayViewModel(trainingDay: day)
    }
    
//    func getTrainingDetail() -> TrainingHoursViewModel {
//        return TrainingHoursViewModel()
//    }
    
    func daysOnCurrentMonth() {
        let currentDate = Date() // Tras a data atual
        let dateFormatter = DateFormatter() // Formatador de data
        let calendar = Calendar.current // Componente de calendario
        let year = calendar.component(.year, from: currentDate) // Retornao o ano atual do dispositivo
        let month = calendar.component(.month, from: currentDate) // Retornao o mes atual do dispositivo

        // Retorna um range de dias do mes atual do dispositivo
        let range = calendar.range(of: .day, in: .month, for: currentDate)
        
        range?.forEach({ day in
            // Formata a data no padrao ano/mes/dia - ISO
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: "\(year)/\(month)/\(day)") {
                dateFormatter.dateFormat = "EEE"
                let dayName = dateFormatter.string(from: date)
                let dayFormatted = String(format: "%02d", day)
                trainingDays[dayFormatted] = dayName
            }
        })
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
