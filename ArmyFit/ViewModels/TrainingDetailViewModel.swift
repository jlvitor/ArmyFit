//
//  TrainingDetailViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 08/06/22.
//

import Foundation


class TrainingDetailViewModel {
    private let details: TrainingUser
    
    init(details: TrainingUser) {
        self.details = details
    }
    
    func getUserImage() -> String {
        guard let image = details.user?.photoURL else { return "" }
        
        return image
    }
    
    func getUserName() -> String {
        guard let name = details.user?.name else { return ""}
        
        return name
    }
    
    func getDay() {
        
    }
    
    func getHour() {
        
    }
    
    func getCoachName() {
        
    }
    
    func getAvaliableSpots() {
        
    }
    
    func getSpots() {
        
    }
    
}
