//
//  FolderModel.swift
//  Paro
//
//  Created by Jeremy Ok on 7/25/25.
//

import Foundation

@Observable class FolderModel {
    var folders: [Folder] = []
    
    init (folders: [Folder]) {
        self.folders = folders;
    }
    
    
    func addFolder(_ folder: Folder) throws {
        if let _ = self.folders.firstIndex(of: folder) {
            throw DataValidationError.duplicateFolder
        } else {
            self.folders.append(folder)
        }
        
        print(self.folders)

        
    }
    
    func deleteFolder(_ folder: Folder) {
        if let index = self.folders.firstIndex(of: folder) {
            self.folders.remove(at: index)
        }
    }
}

