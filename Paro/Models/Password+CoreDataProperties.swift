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
        hashedPassword_ ?? ""
    }
    var hint: String {
        hint_ ?? ""
    }
    var name: String {
        name_ ?? ""
    }
    var salt: String {
        salt_ ?? ""
    }
    
    convenience init(name: String, password: String, hint: String, context: NSManagedObjectContext) throws {
        self.init(context: context)
        self.salt_ = String.randomString(length: 10)
        self.name_ = name
        self.hashedPassword_ = try Password.hashPassword(salt, password)
        self.hint_ = hint
        self.locked_ = true
    }
    
    static func fetchPasswords(context: NSManagedObjectContext) -> PasswordModel {
        let request: NSFetchRequest<Password> = Password.fetchRequest()
        request.predicate = nil
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        
        return PasswordModel(passwords: try! context.fetch(request))
        
    }
    
    // MARK: Preview helpers
    var previewPasswords: [Password] {
        let context = PersistenceController.preview.container.viewContext
        var passwords: [Password] = []
        for index in 1..<3 {
            passwords.append(try! Password(name: "\(name)\(index)", password: "Test\(index)", hint: "\(hint)\(index)", context: context))
        }
        return passwords
    }
    
    // MARK: Preview Helpers
    static var createPasswordModelHelper: PasswordModel {
        let context = PersistenceController.preview.container.viewContext
        let passwordModel = PasswordModel(passwords: [])
        try! passwordModel.addPassword(name: "Test", password: "Test", hint: "Test", context: context)
        return passwordModel
    }
}
