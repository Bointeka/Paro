//
//  PasswordDev.swift
//  Paro
//
//  Created by Jeremy Ok on 8/6/25.
//
import Foundation
import CryptoSwift

@Observable class PasswordDev: Identifiable {
    var id : String { self.name }
    var name: String
    var hash: String
    var salt: String
    var hint: String
    
    init (name: String) {
        self.name = name
        self.hash = ""
        self.salt = ""
        self.hint = ""
    }
    
    init (name: String, password: String, hint: String) throws {
        let saltString = String.randomString(length: 10);
        self.hash = try PasswordDev.hashPassword(saltString, password)
        self.name = name
        self.hint = hint
        self.salt = saltString
    }
    
    static func hashPassword(_ salt : String, _ password: String) throws -> String {
        do {
            let key = try PKCS5.PBKDF2(
                password: password.bytes,
                salt: salt.bytes,
                iterations: 100_000,
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
                iterations: 100_000,
                keyLength: 32,
                variant: .sha2(.sha256)
            ).calculate()

            if (key.toHexString() == self.hash) {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
