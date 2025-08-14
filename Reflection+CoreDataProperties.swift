//
//  Reflection+CoreDataProperties.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//
//

import Foundation
import CoreData


extension Reflection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reflection> {
        return NSFetchRequest<Reflection>(entityName: "Reflection")
    }

    @NSManaged public var text_: String?
    @NSManaged public var timestamp_: Date?
    @NSManaged public var note: Note?

}

extension Reflection : Identifiable {
    var text: String {
        get { text_ ?? ""}
        set { text_ = newValue }
    }
    var timestamp: Date {
        get { timestamp_ ?? Date()}
        set { timestamp_ = newValue }
    }
}
