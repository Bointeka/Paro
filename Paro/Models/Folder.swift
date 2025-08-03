//
//  Folder.swift
//  Paro
//
//  Created by Jeremy Ok on 7/31/25.
//

import Foundation

struct Folder: Equatable, Identifiable {
    var id: String {name}
    var name: String
    var notes : [Note] = []
    var folders : [Folder] = []
    
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.name == rhs.name 
    }
    
    mutating func addNote(_ note: Note) {
        self.notes.append(note)
    }
    
    mutating func deleteNote(_ note: Note) {
        if let index = self.notes.firstIndex(of: note) {
            self.notes.remove(at: index)
        }
    }
    
    
    mutating func addFolder(_ folder: Folder) throws {
        if let _ = self.folders.firstIndex(of: folder) {
            throw DataValidationError.duplicateFolder
        } else {
            self.folders.append(folder)
        }
        
        print(self.folders)

        
    }
    
    mutating func deleteFolder(_ folder: Folder) {
        if let index = self.folders.firstIndex(of: folder) {
            self.folders.remove(at: index)
        }
    }
    
    func getNoteCount() -> Int {
        return notes.count
    }
}


