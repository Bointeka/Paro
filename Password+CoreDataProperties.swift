//
//  Password+CoreDataProperties.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//
//

import Foundation
import CoreData


extension Password {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Password> {
        return NSFetchRequest<Password>(entityName: "Password")
    }

    @NSManaged public var hashedPassword_: String?
    @NSManaged public var hint_: String?
    @NSManaged public var locked_: Bool
    @NSManaged public var name_: String?
    @NSManaged public var salt_: String?
    @NSManaged public var folder: Folders?

}

extension Password : Identifiable {
    var hashedPassword: String {
        get { hashedPassword_ ?? "" }
        set { hashedPassword_ = newValue }
    }
    var hint: String {
        get { hint_ ?? "" }
        set { hint_ = newValue }
    }
    var name: String {
        get { name_ ?? ""}
        set { name_ = newValue }
    }
    var salt: String {
        get { salt_ ?? "" }
        set { salt_ = newValue }
    }
}
