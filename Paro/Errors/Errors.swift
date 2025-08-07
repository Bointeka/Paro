//
//  Errors.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//
import Foundation

enum DataValidationError : Error, LocalizedError {
    case duplicateFolder
    
    var errorDescription: String? {
        switch self {
        case .duplicateFolder:
            return "There is already a folder with the same name."
        }
    }
}

enum PasswordError: Error, LocalizedError {
    case hashingFailed
    case incorrectPassword
    
    var errorDescription: String? {
        switch self {
        case .hashingFailed:
            return "Failed to hash password."
        case .incorrectPassword:
            return "Incorrect password."
        }
    }
}
