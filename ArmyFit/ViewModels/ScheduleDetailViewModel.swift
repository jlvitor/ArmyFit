//
//  TrainingDetailViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 08/06/22.
//

import Foundation

protocol ScheduleDetailViewModelDelegate {
    func reloadData()
}

class ScheduleDetailViewModel {
    
    private let service: TrainingHoursService
    private var hourDetail: TrainingHours
    
    var delegate: ScheduleDetailViewModelDelegate?
    
    init(service: TrainingHoursService = .init() , _ hourDetail: TrainingHours) {
        self.service = service
        self.hourDetail = hourDetail
    }
    
    func makeTrainingRegister() {
        guard let userId = UserDefaults.getValue(key: UserDefaults.Keys.userId) as? String else { return }
        let trainingHoursId = hourDetail.id
        service.addUserOnTraining(trainingHoursId, userId) { _, error in
            if error != nil {
                print(error)
            }
            
            self.delegate?.reloadData()
        }
    }
    
    func getHourTraining() -> String {
        let trainingHour = hourDetail.date_hour
        return Date.formatDateStringToHour(date: trainingHour)
    }
    
    func getMinuteTraining() -> String {
        let trainingMinute = hourDetail.date_hour
        return Date.formatDateStringToMinute(date: trainingMinute)
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
        guard let users = hourDetail.training_users?.count else { return 0 }
        return users
    }
    
    func getTrainingDetailCellViewModel() -> RegisterTrainingViewModel {
        let user = hourDetail
        return RegisterTrainingViewModel(trainingDetail: user)
    }
    
    private func convertToUppercasedFrom(_ text: String) -> String {
        return text.uppercased()
    }
}

