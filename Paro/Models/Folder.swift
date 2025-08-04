//
//  Folder.swift
//  Paro
//
//  Created by Jeremy Ok on 7/31/25.
//

import Foundation

@Observable class Folder: Equatable, Identifiable {
    var id: String {name}
    var name: String
    var notes : [Note]
    var folders : [Folder]
    
    init (name: String) {
        self.name = name
        self.notes = []
        self.folders = []
    }
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.name == rhs.name 
    }
    
     func addNote(_ note: Note) {
        self.notes.append(note)
    }
    
     func deleteNote(_ note: Note) {
        if let index = self.notes.firstIndex(of: note) {
            self.notes.remove(at: index)
        }
    }
    
    
     func addFolder(_ folder: Folder) throws {
        if let _ = self.folders.firstIndex(of: folder) {
            throw DataValidationError.duplicateFolder
        } else {
            self.folders.append(folder)
        }
    }
    
     func deleteFolder(_ folder: Folder) {
        if let index = self.folders.firstIndex(of: folder) {
            self.folders.remove(at: index)
        }
    }
    
    func getNoteCount() -> Int {
        return notes.count
    }
}


