//
//  TrainingUser+CoreDataProperties.swift
//  
//
//  Created by Jean Lucas Vitor on 06/07/22.
//
//

import Foundation
import CoreData


extension TrainingUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrainingUser> {
        return NSFetchRequest<TrainingUser>(entityName: "TrainingUser")
    }

    @NSManaged public var trainingHours: TrainingHours?

}
