//
//  Folders+CoreDataClass.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//
//

import Foundation
import CoreData

@objc(Folders)
public class Folders: NSManagedObject {

    static func == (lhs: Folders, rhs: Folders) -> Bool {
        return lhs.name == rhs.name
    }
    
    
    func addNote(_ note: Note) throws {
        guard let context = note.managedObjectContext else { return }
        if (note.title != ""){
            addToNotes_(note)
            try context.save()
        }
    }
    
    func deleteNote(_ note: Note) {
        guard let context = note.managedObjectContext else { return }
        context.delete(note)
    }
    
    
    func addFolder(_ folder: Folders) throws {
        guard let context = folder.managedObjectContext else { return }
        if folder.name == "nil"{
            throw DataValidationError.invalidName
        } else {
            addToFolders_(folder)
            try context.save()
        }
    }

    func deleteFolder(_ folder: Folders) {
        guard let context = folder.managedObjectContext else { return }
        context.delete(folder)
    }
    
    func getNoteCount() -> Int {
        return notes.count
    }
    
}
