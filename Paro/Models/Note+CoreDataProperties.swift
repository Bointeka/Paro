//
//  Note+CoreDataProperties.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var text_: String?
    @NSManaged public var timestamp_: Date?
    @NSManaged public var title_: String?
    @NSManaged public var folder: Folders?
    @NSManaged public var reflections_: NSSet?

}

// MARK: Generated accessors for reflections
extension Note {

    @objc(addReflections_Object:)
    @NSManaged public func addToReflections_(_ value: Reflection)

    @objc(removeReflections_Object:)
    @NSManaged public func removeFromReflections_(_ value: Reflection)

    @objc(addReflections_:)
    @NSManaged public func addToReflections_(_ values: NSSet)

    @objc(removeReflections_:)
    @NSManaged public func removeFromReflections_(_ values: NSSet)

}

extension Note : Identifiable {
    var text: String {
        get { text_ ?? ""}
        set { text_ = newValue }
    }
    var timestamp: Date {
        timestamp_ ?? Date()
    }
    var title: String {
        get { title_ ?? ""}
        set { title_ = newValue }
    }
    
    var reflections: Set<Reflection> {
        get { (reflections_ as? Set<Reflection>) ?? []}
        set { reflections_ = newValue as NSSet }
    }
    
    public override func awakeFromInsert() {
        self.timestamp_ = Date()
    }
    
    // MARK: Preview helper
    static var notePreviewHelper: Note {
        let context = PersistenceController.preview.container.viewContext
        return Note(context: context)
    }
}
