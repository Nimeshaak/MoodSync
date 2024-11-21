//
//  Persistence.swift
//  MoodSync
//
//  Created by Gihan Nemindra on 11/20/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newMood = Mood(context: viewContext)
            newMood.selectedEmoji = i % 2 == 0 ? "😊" : "😢"
            newMood.timestamp = Calendar.current.date(byAdding: .day, value: -i, to: Date())
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this with appropriate error handling.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MoodSync")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this with appropriate error handling.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
