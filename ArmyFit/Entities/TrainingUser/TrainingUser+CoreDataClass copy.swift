//
//  TrainingUser+CoreDataClass.swift
//  
//
//  Created by Jean Lucas Vitor on 05/07/22.
//
//

import Foundation
import CoreData

@objc(TrainingUser)
public class TrainingUser: NSManagedObject {

    convenience init(_ trainingUser: TrainingUserDTO, context: NSManagedObjectContext) {
        self.init(context: context)
        self.trainingHours?.dateHour = trainingUser.trainingHours?.dateHour ?? ""
        self.trainingHours?.instructor = trainingUser.trainingHours?.instructor ?? ""
        self.trainingHours?.training.name = trainingUser.trainingHours?.training.name ?? ""
        self.trainingHours?.training.warning = trainingUser.trainingHours?.training.warning ?? ""
        self.trainingHours?.trainingDescription = trainingUser.trainingHours?.description ?? ""
    }
    
}
