//
//  Note+CoreDataClass.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    func getTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: timestamp)
    }
    
    func addReflection(_ text: String, context: NSManagedObjectContext) throws {
        if (text != "" ) {
            addToReflections_(Reflection(id: Int64(reflections.count), text: text, context: context))
            do {
                try context.save()
            } catch {
                throw FileSystemError.unableToSave
            }
        }
    }
    
    func deleteReflection(_ reflection: Reflection) {
        guard let context = reflection.managedObjectContext else { return }
        
        context.delete(reflection)
        try! context.save()
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func searchNotes(context: NSManagedObjectContext, search: String) -> [Note] {
        let request:NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "(title_ CONTAINS[cd] %@ OR text_ CONTAINS[cd] %@) AND folder.passwordHash == nil", search, search)
        request.sortDescriptors = [NSSortDescriptor(key: "title_", ascending: true), NSSortDescriptor(key: "timestamp_", ascending: false)]
        return try! context.fetch(request)
    }
    
    static func fetchNotes(context: NSManagedObjectContext, folder: Folders) -> [Note] {
        let request:NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "folder == %@", folder)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp_", ascending: false)]
        return try! context.fetch(request)
    }
    
}
