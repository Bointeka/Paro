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

    @NSManaged public var id: Int64
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
        timestamp_ ?? Date()
    }
    
    convenience init(id: Int64, text: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = 0
        self.text = text
    }
    
    public override func awakeFromInsert() {
        self.timestamp_ = Date()
    }
    
    //MARK: Preview Helpers
    public static var reflectionPreview: Reflection {
        let context = PersistenceController.preview.container.viewContext
        return Reflection(id: 0, text: "Test is really long. Lets think of a long as phrase that is longer than this and how it would look like in the item. It is mererly a reflection.", context: context)
    }
}
