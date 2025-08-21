//
//  Password+CoreDataClass.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//
//

import Foundation
import CoreData
import CryptoSwift

@objc(Password)
public class Password: NSManagedObject {
    static func hashPassword(_ salt : String, _ password: String) throws -> String {
        do {
            let key = try PKCS5.PBKDF2(
                password: password.bytes,
                salt: salt.bytes,
                iterations: 1,
                //iterations: 100_000,
                keyLength: 32,
                variant: .sha2(.sha256)
            ).calculate()

            return key.toHexString()
        } catch {
            throw PasswordError.hashingFailed
        }
     }
    
    func comparePassword(_ password: String) -> Bool  {
        do {
            let key = try PKCS5.PBKDF2(
                password: password.bytes,
                salt: salt.bytes,
                iterations: 1,
                keyLength: 32,
                variant: .sha2(.sha256)
            ).calculate()
            if (key.toHexString() == self.hashedPassword) {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func unlock(_ password: String) -> Bool{
        if (self.locked_ && comparePassword(password)) {
            willChangeValue(forKey: "locked_")
            self.locked_.toggle()
            didChangeValue(forKey: "locked_")
            return true
        }
        return false
    }
    
    func lock() {
        if (!self.locked_) {
            self.locked_.toggle()
        }
    }
    
    static func == (lhs: Password, rhs: Password) -> Bool {
        return lhs.hashedPassword == rhs.hashedPassword
    }
}
