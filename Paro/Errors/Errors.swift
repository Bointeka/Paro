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
