//
//  Folder.swift
//  Paro
//
//  Created by Jeremy Ok on 7/31/25.
//

import Foundation
import CoreData

@Observable class FolderDev: Equatable, Identifiable, Hashable {
    var id: String {name}
    var name: String
    var notes : [Note]
    var folders : [FolderDev]
    var passwordHash: Password?
    
    init () {
        self.name = "nil"
        self.notes = []
        self.folders = []
        self.passwordHash = nil
    }
    
    
    init (name: String, passwordHash: Password?) {
        self.name = name
        self.notes = []
        self.folders = []
        self.passwordHash = passwordHash
    }
    
    static func == (lhs: FolderDev, rhs: FolderDev) -> Bool {
        return lhs.name == rhs.name
    }
    
    func addNote(_ note: Note) {
        guard let context = note.managedObjectContext else { return }
        if let _ = self.notes.firstIndex(where: { $0.id == note.id }) {
            //Do nothing since it is already in the array
        } else if (note.title != ""){
            //note.id = notes.count
            self.notes.append(note)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
     func deleteNote(_ note: Note) {
         guard let context = note.managedObjectContext else { return }
         
         context.delete(note)
    }
    
    
     func addFolder(_ folder: FolderDev) throws {
        if let _ = self.folders.firstIndex(of: folder) {
            throw DataValidationError.duplicateFolder
        } else if folder.name == "" || folder.name == "nil"{
            throw DataValidationError.invalidName
        } else {
            self.folders.append(folder)
        }
    }
    
     func deleteFolder(_ folder: FolderDev) {
        if let index = self.folders.firstIndex(of: folder) {
            self.folders.remove(at: index)
        }
    }
    
    func getNoteCount() -> Int {
        return notes.count
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}


