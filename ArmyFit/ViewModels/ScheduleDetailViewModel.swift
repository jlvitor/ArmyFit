//
//  TrainingDetailViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 08/06/22.
//

import Foundation

protocol ScheduleDetailViewModelDelegate {
    func success()
    func reloadData()
}

protocol RegisterOnTrainingDelegate {
    func showAlertAddUserOnTraining()
    func showAlertRemoveUserOnTraining()
    func success()
}

class ScheduleDetailViewModel {
    
    private let service: TrainingHoursService
    private let trainingHoursId: String
    private var isRegistered: Bool = false
    private var traininigHoursDetail: TrainingHours = .init(
        id: "",
        date_hour: "",
        spots: 0,
        available_spots: 0,
        instructor: "",
        description: "",
        training: Training.init(id: "", name: "", created_at: "", warning: "", trainingHours: nil),
        training_id: "",
        training_users: nil)
    
    var delegate: ScheduleDetailViewModelDelegate?
    var registerDelegate: RegisterOnTrainingDelegate?
    
    init(service: TrainingHoursService = .init() , _ trainingHoursId: String) {
        self.service = service
        self.trainingHoursId = trainingHoursId
    }
    
    func fetchTrainingsHours(completion: @escaping () -> Void) {
        service.getTrainingHours(trainingHoursId) { success, error in
            guard let success = success else {
                return
            }
            self.traininigHoursDetail = success
            self.userIsRegistered()
            self.delegate?.reloadData()
            completion()
        }
    }
    
    func addUserOnTraining() {
        guard let userId = UserDefaults.getValue(key: UserDefaults.Keys.userId) as? String else { return }
        
        service.addUserOnTraining(trainingHoursId, userId) { _, error in
            if error != nil {
                print("Error \(error?.localizedDescription)")
            } else {
                self.registerDelegate?.success()
            }
        }
    }
    
    func removeUserOnTraining() {
        guard let trainingUser = traininigHoursDetail.training_users else { return }
        let id = trainingUser[0].id
        
        service.removeUserOnTraining(id) { _, error in
            if error != nil {
                print("Error \(error?.localizedDescription)")
            } else {
                self.registerDelegate?.success()
            }
        }
    }
    
    func getDayName() -> String {
        let dayName = Date.getDayNameFromString(date: traininigHoursDetail.date_hour)
        return dayName.uppercased()
    }
    
    func getDayNumber() -> String {
        let dayNumber = Date.getDayNumberFromString(date: traininigHoursDetail.date_hour)
        return dayNumber
    }
    
    func getHourTraining() -> String {
        let trainingHour = traininigHoursDetail.date_hour
        return Date.formatDateStringToHour(date: trainingHour)
    }
    
    func getMinuteTraining() -> String {
        let trainingMinute = traininigHoursDetail.date_hour
        return Date.formatDateStringToMinute(date: trainingMinute)
    }
    
    func getCoachName() -> String {
        let coachName = traininigHoursDetail.instructor
        let name = convertToUppercasedFrom(coachName)
        return name
    }
    
    func getAvailableSpots() -> String {
        let availableSpots = traininigHoursDetail.available_spots
        return "\(availableSpots)"
    }
    
    func getSpots() -> String {
        let spots = traininigHoursDetail.spots
        return "\(spots)"
    }
    
    func getNumberOfUsers() -> Int {
        guard let users = traininigHoursDetail.training_users?.count else { return 0 }
        return users
    }
    
    func getTrainingDetailCellViewModel() -> RegisterTrainingViewModel {
        let user = traininigHoursDetail
        return RegisterTrainingViewModel(trainingDetail: user)
    }
    
    func registerButtonPressed() {
        if isRegistered {
            self.registerDelegate?.showAlertRemoveUserOnTraining()
        } else {
            self.registerDelegate?.showAlertAddUserOnTraining()
        }
    }
    
    func getRegisterButtonTitle() -> String {
        if isRegistered {
            return "SAIR DO TREINO"
        } else {
            return "PARTICIPAR DO TREINO"
        }
    }
    
    private func userIsRegistered() {
        guard let trainingUsers = traininigHoursDetail.training_users else { return }
        
        let isRegistered = trainingUsers.contains { user in
            UserDefaults.getValue(key: UserDefaults.Keys.userId) as? String == user.user_id
        }
        
        self.isRegistered = isRegistered
    }
    
    private func convertToUppercasedFrom(_ text: String) -> String {
        return text.uppercased()
    }
}

