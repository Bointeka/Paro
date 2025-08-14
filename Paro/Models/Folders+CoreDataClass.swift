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
    
    /*
    func addNote(_ note: Note) {
        
        if let _ = self.notes.firstIndex(where: { $0.id == note.id }) {
            //Do nothing since it is already in the array
        } else if (note.title != ""){
            note.id = notes.count
            self.notes.append(note)
        }
    }
    
     func deleteNote(_ note: NoteDev) {
        if let index = self.notes.firstIndex(of: note) {
            self.notes.remove(at: index)
        }
    }
    
    
     func addFolder(_ folder: FolderDev) throws {
        if let _ = self.folders.firstIndex(of: folder) {
            throw DataValidationError.duplicateFolder
        } else if folder.name == ""{
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
    }*/
    
}
