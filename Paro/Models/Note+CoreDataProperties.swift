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
    @NSManaged public var reflections: NSSet?

}

// MARK: Generated accessors for reflections
extension Note {

    @objc(addReflectionsObject:)
    @NSManaged public func addToReflections(_ value: Reflection)

    @objc(removeReflectionsObject:)
    @NSManaged public func removeFromReflections(_ value: Reflection)

    @objc(addReflections:)
    @NSManaged public func addToReflections(_ values: NSSet)

    @objc(removeReflections:)
    @NSManaged public func removeFromReflections(_ values: NSSet)

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
    
    public override func awakeFromInsert() {
        self.timestamp_ = Date()
    }
    
}
