//
//  Folders+CoreDataProperties.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//
//

import Foundation
import CoreData


extension Folders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folders> {
        return NSFetchRequest<Folders>(entityName: "Folder")
    }

    @NSManaged public var name_: String?
    @NSManaged public var folders: NSSet?
    @NSManaged public var notes: NSSet?
    @NSManaged public var passwordHash: Password?

}

// MARK: Generated accessors for folders
extension Folders {

    @objc(addFoldersObject:)
    @NSManaged public func addToFolders(_ value: Folders)

    @objc(removeFoldersObject:)
    @NSManaged public func removeFromFolders(_ value: Folders)

    @objc(addFolders:)
    @NSManaged public func addToFolders(_ values: NSSet)

    @objc(removeFolders:)
    @NSManaged public func removeFromFolders(_ values: NSSet)

}

// MARK: Generated accessors for notes
extension Folders {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension Folders : Identifiable {
    var name : String {
        set { name_ = newValue}
        get { name_ ?? ""}
    }
    
}
