//
//  PasswordModel.swift
//  Paro
//
//  Created by Jeremy Ok on 8/8/25.
//

import Foundation
import CoreData

@Observable class PasswordModel  {
    var passwords: [Password]
    
    init(passwords: [Password]) {
        self.passwords = passwords
    }
    
    func addPassword(name: String, password: String, hint: String, context: NSManagedObjectContext) throws {
        if let _ = passwords.firstIndex(where: {name == $0.name}) {
            throw DataValidationError.duplicatePassword
        } else {
            self.passwords.append(try Password(name: name, password: password, hint: hint, context: context))
        }
    }
}
