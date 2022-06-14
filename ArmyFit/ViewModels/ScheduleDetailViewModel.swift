//
//  TrainingDetailViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 08/06/22.
//

import Foundation

class ScheduleDetailViewModel {
    private let hourDetail: TrainingHours
    
    init(_ hourDetail: TrainingHours) {
        self.hourDetail = hourDetail
    }
    
    func getHourTraining() -> String {
        let trainingHour = hourDetail.date_hour
        return formatDateStringToHour(date: trainingHour)
    }
    
    func getMinuteTraining() -> String {
        let trainingMinute = hourDetail.date_hour
        return formatDateStringToMinute(date: trainingMinute)
    }
    
    func getCoachName() -> String {
        let coachName = hourDetail.instructor
        let name = convertToUppercasedFrom(coachName)
        return name
    }
    
    func getAvailableSpots() -> String {
        let availableSpots = hourDetail.available_spots
        return "\(availableSpots)"
    }
    
    func getSpots() -> String {
        let spots = hourDetail.spots
        return "\(spots)"
    }
    
    func getNumberOfUsers() -> Int {
        guard let users = hourDetail.training_users?.count else { return 0}
        return users
    }
    
    func getUserImage() -> String {
        guard let userImage = hourDetail.training_users,
              let image = userImage[0].user?.photoURL else { return "person.fill" }
        return image
    }
    
    func getUserName() -> String {
        guard let userName = hourDetail.training_users,
              let name = userName[0].user?.name else { return "Usuário sem nome"}
        return name
    }
    
    private func convertToUppercasedFrom(_ text: String) -> String {
        return text.uppercased()
    }
    
    private func formatDateStringToHour(date: String) -> String {
        // Variavel que instancia formatador de data
        let dateFormatter = DateFormatter()
        // Variavel que recebe a localizacao atual
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
