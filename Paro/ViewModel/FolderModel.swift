//
//  FolderModel.swift
//  Paro
//
//  Created by Jeremy Ok on 7/25/25.
//

import Foundation
import CoreData

@Observable class FolderModel {
    var folders: [Folders] = []
    
    init (folders: [Folders]) {
        self.folders = folders
    }
    
    
    func addFolder(_ folder: Folders, context: NSManagedObjectContext) throws {
        if let _ = self.folders.firstIndex(of: folder) {
            throw DataValidationError.duplicateFolder
        } else {
            self.folders.append(folder)
            folder.folder = nil
            folder.index = Int64(folders.count)
            do {
                try context.save()
            } catch {
                print(error)
                //TODO: Add valid error for addition
            }
        }
    }
    
    func deleteFolder(_ folder: Folders) {
        guard let managedContext = folder.managedObjectContext else { return }
        if let index = folders.firstIndex(of: folder) {
            folders.remove(at: index)
        }
        managedContext.delete(folder)
    }
}

