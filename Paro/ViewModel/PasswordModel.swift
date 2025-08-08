//
//  PasswordModel.swift
//  Paro
//
//  Created by Jeremy Ok on 8/8/25.
//

import Foundation

@Observable class PasswordModel  {
    var passwords: [PasswordDev]
    
    init(passwords: [PasswordDev]) {
        self.passwords = passwords
    }
    
    func addPassword(_ password: PasswordDev) throws {
        if let _ = passwords.firstIndex(where: {password.name == $0.name}) {
            throw DataValidationError.duplicatePassword
        } else {
            self.passwords.append(password)
        }
    }
}
