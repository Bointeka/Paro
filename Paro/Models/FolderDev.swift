//
//  Folder.swift
//  Paro
//
//  Created by Jeremy Ok on 7/31/25.
//

import Foundation

@Observable class FolderDev: Equatable, Identifiable {
    var id: String {name}
    var name: String
    var notes : [NoteDev]
    var folders : [FolderDev]
    var locked : Bool
    var passwordHash: PasswordDev?
    
    init () {
        self.name = ""
        self.notes = []
        self.folders = []
        self.passwordHash = nil
        self.locked = false
    }
    
    
    init (name: String, passwordHash: PasswordDev?) {
        self.name = name
        self.notes = []
        self.folders = []
        self.passwordHash = passwordHash
        if (passwordHash == nil) {
            self.locked = false
        } else {
            self.locked = true
        }
    }
    
    static func == (lhs: FolderDev, rhs: FolderDev) -> Bool {
        return lhs.name == rhs.name
    }
    
     func addNote(_ note: NoteDev) {
        self.notes.append(note)
    }
    
     func deleteNote(_ note: NoteDev) {
        if let index = self.notes.firstIndex(of: note) {
            self.notes.remove(at: index)
        }
    }
    
    
     func addFolder(_ folder: FolderDev) throws {
        if let _ = self.folders.firstIndex(of: folder) {
            throw DataValidationError.duplicateFolder
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
    
    func unlock(_ password: String) {
        if (passwordHash!.comparePassword(password)) {
            self.locked = false
        }
    }
}


