//
//  Reflection+CoreDataProperties.swift
//  Paro
//
//  Created by Jeremy Ok on 8/6/25.
//
//

import Foundation
import CoreData


extension Reflection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reflection> {
        return NSFetchRequest<Reflection>(entityName: "Reflection")
    }

    @NSManaged public var text: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var note: Note?

}

extension Reflection : Identifiable {

}
