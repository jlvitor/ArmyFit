//
//  Date+Extension.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 14/06/22.
//

import Foundation

extension Date {
    
    static func formatDateStringToHour(date: String) -> String {
        let dateFormatter = DateFormatter()
        let locale = NSLocale.current
        let dateFormatterFromLocale = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale)!
        var hour = ""
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        let dateFormatted = dateFormatter.date(from: date)
        guard let dateFormatted = dateFormatted else { return "" }
        
        // TODO: Fazer funcionar formatacao quando relógio for 12h
        if dateFormatterFromLocale.contains("a") {
            dateFormatter.dateFormat = "hh a"
            hour = dateFormatter.string(from: dateFormatted)
        } else {
            dateFormatter.dateFormat = "HH"
            hour = dateFormatter.string(from: dateFormatted)
        }
        return hour
    }
    
    static func formatDateStringToMinute(date: String) -> String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        let dateFormatted = dateFormatter.date(from: date)
        
        guard let dateFormatted = dateFormatted else { return "" }
        
        let minute = calendar.component(.minute, from: dateFormatted)
        let minuteFormatt = String(format: "%02d", minute)
        return minuteFormatt
    }
    
    static func getCurrentDateToDateString() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        let monthFormatted = String(format: "%02d", month)
        let dayFormatted = String(format: "%02d", day)
        
        let dateFormatted = String("\(year)-\(monthFormatted)-\(dayFormatted)")
        return dateFormatted
    }
    
    static func getDayNumberFromString(date: String) -> String {
        var day: Int = 0
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
   
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        if let dateFormatted = dateFormatter.date(from: date) {
            day = calendar.component(.day, from: dateFormatted)
        }
        
        let dayFormatted = String(format: "%02d", day)
        return dayFormatted
    }
    
    static func getDayNameFromString(date: String) -> String {
        var dayName: String = ""
        let dateFormatter = DateFormatter()
   
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        if let dateFormatted = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "EEE"
            dayName = dateFormatter.string(from: dateFormatted)
        }
        
        return dayName
    }
}
