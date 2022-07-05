//
//  TrainingHours+CoreDataClass.swift
//  
//
//  Created by Jean Lucas Vitor on 05/07/22.
//
//

import Foundation
import CoreData

@objc(TrainingHours)
public class TrainingHours: NSManagedObject {

    convenience init(_ trainingUser: TrainingUser, context: NSManagedObjectContext) {
        self.init(context: context)
        self.dateHour = trainingUser.trainingHours?.dateHour ?? ""
        self.instructor = trainingUser.trainingHours?.instructor ?? ""
        self.training.name = trainingUser.trainingHours?.training.name ?? ""
        self.training.warning = trainingUser.trainingHours?.training.warning ?? ""
        self.trainingDescription = trainingUser.trainingHours?.description ?? ""
    }
}
