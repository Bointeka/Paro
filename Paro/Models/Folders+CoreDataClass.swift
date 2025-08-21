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
        try! context.save()
    }
    
    
    func addFolder(_ folder: Folders) throws {
        guard let context = folder.managedObjectContext else { return }
        if folder.name == "nil"{
            throw DataValidationError.invalidName
        } else {
            folder.index = Int64(folders.count)
            addToFolders_(folder)
            try context.save()
        }
    }

    func deleteFolder(_ folder: Folders) {
        guard let context = folder.managedObjectContext else { return }
        context.delete(folder)
        try! context.save()
    }
    
    func getNoteCount() -> Int {
        return notes.count
    }
    
    static func fetchRootFolders(context: NSManagedObjectContext) -> FolderModel {
        let request:NSFetchRequest<Folders> = Folders.fetchRequest()
        request.predicate = NSPredicate(format: "folder == nil")
        request.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        let folders = try! context.fetch(request)
        let folderModel = FolderModel(folders: folders)
        return folderModel
    }
    
    static func searchFolders(context: NSManagedObjectContext, search: String) -> [Folders] {
            let request:NSFetchRequest<Folders> = Folders.fetchRequest()
            request.predicate = NSPredicate(format: "name_ CONTAINS[cd] %@", search)
            request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
            return try! context.fetch(request)
    }
    
    static func fetchSubFolders(context: NSManagedObjectContext, folder: Folders) -> [Folders] {
        let request:NSFetchRequest<Folders> = Folders.fetchRequest()
        request.predicate = NSPredicate(format: "folder == %@", folder)
        request.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        return try! context.fetch(request)
    }
}

