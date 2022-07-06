//
//  CoreDataService.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 05/07/22.
//

import Foundation
import CoreData

class CoreDataService {
    
    private let context = CoreDataManager.shared.context
    
    static var shared = CoreDataService()
    
    var sampleImageData: Data = .init()
    var storedImageData: Data = .init()
    
    func saveOnCoreData() {
        let image: User = .init(context: context)
        
        image.photoUrl = sampleImageData
        saveContext()
    }
    
    func fetchUserImage() -> [User] {
        do {
            return try context.fetch(User.fetchRequest())
        } catch {
            print(error)
        }
        
        return []
    }
    
    private func saveContext() {
        CoreDataManager.shared.saveContext()
    }
}
