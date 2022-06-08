//
//  TrainingDetailViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 08/06/22.
//

import Foundation

protocol TrainingDetailViewModelDelegate {
    
    func success(_ viewModel: TrainingHoursViewModel)
    func errorRequest()

}

class TrainingDetailViewModel {
    
    var delegate: TrainingDetailViewModelDelegate?
    
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
