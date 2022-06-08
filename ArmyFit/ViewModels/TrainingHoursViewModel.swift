//
//  TrainingViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 07/06/22.
//

import Foundation

class TrainingHoursViewModel {
    
    private let trainingHours: TrainingHours
    
    init(_ trainingHours: TrainingHours) {
        self.trainingHours = trainingHours
    }
    
    func getHourTraining() -> String {
        let trainingHour = trainingHours.date_hour
        return formatDateStringToHour(date: trainingHour)
    }
    
    func getMinuteTraining() -> String {
        let trainingMinute = trainingHours.date_hour
        return formatDateStringToMinute(date: trainingMinute)
    }
    
    func getTrainingName() -> String {
        let trainingName = trainingHours.training.name
        let title = convertToUppercasedFrom(trainingName)
        return title
    }
    
    func getCoachName() -> String {
        let coachName = trainingHours.instructor
        let name = convertToUppercasedFrom(coachName)
        return name
    }
    
    func getAvailableSpots() -> String {
        let availableSpots = trainingHours.availabe_spots
        return "\(availableSpots)"
    }
    
    func getSpots() -> String {
        let spots = trainingHours.spots
        return "\(spots)"
    }
    
    private func convertToUppercasedFrom(_ text: String) -> String {
        return text.uppercased()
    }
    
    private func formatDateStringToHour(date: String) -> String {
        // Variavel que instancia formatador de data
        let dateFormatter = DateFormatter()
        // Variavel que instacia locale
        let locale = NSLocale.current
        // Variavel que instancia formatador atraves do locale
        let dateFormatterFromLocale = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale)!
        // Variavel que vai receber o valor 24h ou 12h
        var hour = ""
    
        // Define o formato ao qual o dado precisa ser retornado
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        // Guarda o valor formatado
        let dateFormatted = dateFormatter.date(from: date)
        // Desembrulha o dado para ser utilizado
        guard let dateFormatted = dateFormatted else { return "" }
        
        // Se o dateFormatterFromLocale conter "a"
        if dateFormatterFromLocale.contains("a") {
            // Retorna formato 12h
            dateFormatter.dateFormat = "hh a"
            hour = dateFormatter.string(from: dateFormatted)
        } else {
            // Se nao retorna formato 24h
            dateFormatter.dateFormat = "HH"
            hour = dateFormatter.string(from: dateFormatted)
        }
        return hour
    }
    
    private func formatDateStringToMinute(date: String) -> String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatted = dateFormatter.date(from: date)
        
        guard let dateFormatted = dateFormatted else { return "" }
        
        let minute = calendar.component(.minute, from: dateFormatted)
        let minuteFormatt = String(format: "%02d", minute)
        return minuteFormatt
    }
}
