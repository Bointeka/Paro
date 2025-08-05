//
//  FolderModel.swift
//  Paro
//
//  Created by Jeremy Ok on 7/25/25.
//

import Foundation

@Observable class FolderModel {
    var folders: [FolderDev] = []
    
    init (folders: [FolderDev]) {
        self.folders = folders;
    }
    
    
    func addFolder(_ folder: FolderDev) throws {
        if let _ = self.folders.firstIndex(of: folder) {
            throw DataValidationError.duplicateFolder
        } else {
            self.folders.append(folder)
        }
        
        print(self.folders)

        
    }
    
    func deleteFolder(_ folder: FolderDev) {
        if let index = self.folders.firstIndex(of: folder) {
            self.folders.remove(at: index)
        }
    }
}

