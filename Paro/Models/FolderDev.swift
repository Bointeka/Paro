//
//  Folder.swift
//  Paro
//
//  Created by Jeremy Ok on 7/31/25.
//

import Foundation

@Observable class FolderDev: Equatable, Identifiable, Hashable {
    var id: String {name}
    var name: String
    var notes : [NoteDev]
    var folders : [FolderDev]
    var passwordHash: PasswordDev?
    
    init () {
        self.name = ""
        self.notes = []
        self.folders = []
        self.passwordHash = nil
    }
    
    
    init (name: String, passwordHash: PasswordDev?) {
        self.name = name
        self.notes = []
        self.folders = []
        self.passwordHash = passwordHash
    }
    
    static func == (lhs: FolderDev, rhs: FolderDev) -> Bool {
        return lhs.name == rhs.name
    }
    
    func addNote(_ note: NoteDev) {
        if let _ = self.notes.firstIndex(where: { $0.id == note.id }) {
            //Do nothing since it is already in the array
        } else {
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
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}


