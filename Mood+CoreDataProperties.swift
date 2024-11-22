//
//  Mood+CoreDataProperties.swift
//  MoodSync
//
//  Created by COBSCCOMPY4231P-028 on 2024-11-22.
//
//

import Foundation
import CoreData


extension Mood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mood> {
        return NSFetchRequest<Mood>(entityName: "Mood")
    }

    @NSManaged public var lastUpdated: Date?
    @NSManaged public var note: String?
    @NSManaged public var selectedEmoji: String?
    @NSManaged public var timestamp: Date?

}

extension Mood : Identifiable {

}
