//
//  User+CoreDataProperties.swift
//  
//
//  Created by Jean Lucas Vitor on 06/07/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var photoUrl: Data?

}
