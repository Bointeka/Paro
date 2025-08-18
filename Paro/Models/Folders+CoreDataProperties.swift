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
    @NSManaged public var index: Int64
    @NSManaged public var root: Bool
    @NSManaged public var folders_: NSSet?
    @NSManaged public var notes_: NSSet?
    @NSManaged public var passwordHash: Password?
    @NSManaged public var folder: Folders?

}

// MARK: Generated accessors for folders
extension Folders {

    @objc(addFolders_Object:)
    @NSManaged public func addToFolders_(_ value: Folders)

    @objc(removeFolders_Object:)
    @NSManaged public func removeFromFolders_(_ value: Folders)

    @objc(addFolders_:)
    @NSManaged public func addToFolders_(_ values: NSSet)

    @objc(removeFolders_:)
    @NSManaged public func removeFromFolders_(_ values: NSSet)

}

// MARK: Generated accessors for notes
extension Folders {

    @objc(addNotes_Object:)
    @NSManaged public func addToNotes_(_ value: Note)

    @objc(removeNotes_Object:)
    @NSManaged public func removeFromNotes_(_ value: Note)

    @objc(addNotes_:)
    @NSManaged public func addToNotes_(_ values: NSSet)

    @objc(removeNotes_:)
    @NSManaged public func removeFromNotes_(_ values: NSSet)

}

extension Folders : Identifiable {
    var name : String {
        name_ ?? "nil"
    }
    var folders: Set<Folders> {
        get { folders_ as? Set<Folders> ?? []}
        set { folders_ = newValue as NSSet}
    }
    var notes: Set<Note> {
        get { notes_ as? Set<Note> ?? []}
        set { notes_ = newValue as NSSet}
    }
    
    
    convenience init(name: String, passwordHash: Password?, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name_ = name
        self.passwordHash = passwordHash
    }
    
    convenience init(name: String, context: NSManagedObjectContext) {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = context
        self.init(context:childContext)
        self.name_ = name
    }
    
    //MARK: Preview FolderModel Helpers
    static var previewFolderModel: FolderModel {
        let context =  PersistenceController.preview.container.viewContext
        let folderModel: FolderModel = FolderModel(folders: [])
        
        for index in 1..<5 {
            try! folderModel.addFolder(Folders(name: "Folder \(index)", passwordHash: nil, context: context), context: context)
        }
        
        return folderModel
        
    }
    
    // MARK: Preview Helpers
    static var folderPreviewHelper: Folders {
        let context = PersistenceController.preview.container.viewContext
        return Folders(name: "Test", passwordHash: nil, context: context)
    }
    
}



