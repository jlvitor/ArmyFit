//
//  TrainingHours+CoreDataProperties.swift
//  
//
//  Created by Jean Lucas Vitor on 05/07/22.
//
//

import Foundation
import CoreData


extension TrainingHours {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrainingHours> {
        return NSFetchRequest<TrainingHours>(entityName: "TrainingHours")
    }

    @NSManaged public var dateHour: String
    @NSManaged public var instructor: String
    @NSManaged public var trainingDescription: String
    @NSManaged public var training: Training
    @NSManaged public var trainingUsers: NSSet?

}

// MARK: Generated accessors for trainingUsers
extension TrainingHours {

    @objc(addTrainingUsersObject:)
    @NSManaged public func addToTrainingUsers(_ value: TrainingUser)

    @objc(removeTrainingUsersObject:)
    @NSManaged public func removeFromTrainingUsers(_ value: TrainingUser)

    @objc(addTrainingUsers:)
    @NSManaged public func addToTrainingUsers(_ values: NSSet)

    @objc(removeTrainingUsers:)
    @NSManaged public func removeFromTrainingUsers(_ values: NSSet)

}
