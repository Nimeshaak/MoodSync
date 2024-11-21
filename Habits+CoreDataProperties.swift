//
//  Habits+CoreDataProperties.swift
//  MoodSync
//
//  Created by Gihan Nemindra on 11/20/24.
//
//

import Foundation
import CoreData


extension Habits {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habits> {
        return NSFetchRequest<Habits>(entityName: "Habits")
    }

    @NSManaged public var habitName: String?
    @NSManaged public var habitDescription: String?
    @NSManaged public var selectedDays: Data?
    @NSManaged public var reminderTime: Date?
    @NSManaged public var reminderNote: String?

}

extension Habits : Identifiable {

}
