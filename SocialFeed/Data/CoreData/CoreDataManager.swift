//
//  CoreDataManager.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//


import CoreData

final class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "SocialFeed")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

