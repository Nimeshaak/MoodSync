//
//  Habit+CoreDataProperties.swift
//  MoodSync
//
//  Created by COBSCCOMPY4231P-028 on 2024-11-22.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var reminderNote: String?
    @NSManaged public var reminderTime: Date?
    @NSManaged public var selectedDays: String?

}

extension Habit : Identifiable {

}
