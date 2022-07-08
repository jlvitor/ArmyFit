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
    
    func saveImageOnCoreData(sampleImageData: Data) {
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
    
    func deleteUserFromCoreData(user: User) {
        context.delete(user)
        saveContext()
    }
    
    private func saveContext() {
        CoreDataManager.shared.saveContext()
    }
}
