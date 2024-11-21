//
//  Mood+CoreDataProperties.swift
//  MoodSync
//
//  Created by Gihan Nemindra on 11/20/24.
//
//

import Foundation
import CoreData


extension Mood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mood> {
        return NSFetchRequest<Mood>(entityName: "Mood")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var selectedEmoji: String?

}

extension Mood : Identifiable {

}
