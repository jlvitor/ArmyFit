//
//  Training+CoreDataProperties.swift
//  
//
//  Created by Jean Lucas Vitor on 06/07/22.
//
//

import Foundation
import CoreData


extension Training {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Training> {
        return NSFetchRequest<Training>(entityName: "Training")
    }

    @NSManaged public var name: String?
    @NSManaged public var warning: String?
    @NSManaged public var trainingHours: NSSet?

}

// MARK: Generated accessors for trainingHours
extension Training {

    @objc(addTrainingHoursObject:)
    @NSManaged public func addToTrainingHours(_ value: TrainingHours)

    @objc(removeTrainingHoursObject:)
    @NSManaged public func removeFromTrainingHours(_ value: TrainingHours)

    @objc(addTrainingHours:)
    @NSManaged public func addToTrainingHours(_ values: NSSet)

    @objc(removeTrainingHours:)
    @NSManaged public func removeFromTrainingHours(_ values: NSSet)

}
