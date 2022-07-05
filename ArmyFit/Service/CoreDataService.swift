//
//  CoreDataService.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 05/07/22.
//

import Foundation
import CoreData

class CoreDataService {
    
    private let context = CoreDataManager.shared.persistentContainer.viewContext
    
    func saveOnCoreData(_ trainingUser: [TrainingUserDTO]) {
        
        trainingUser.forEach { trainingUser in
            let delegate = CoreDataManager.shared.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "TrainingUser", in: delegate)
            let training = TrainingUser(trainingUser, context: context)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTrainingUser() -> [TrainingUser] {
        do {
            return try context.fetch(TrainingUser.fetchRequest())
        } catch {
            print(error)
        }
        
        return []
    }
    
    private func saveContext() {
        CoreDataManager.shared.saveContext()
    }
}
