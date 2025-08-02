//
//  Folder.swift
//  Paro
//
//  Created by Jeremy Ok on 7/31/25.
//

import Foundation

struct Folder: Equatable {
    var name: String
    var notes : [Note] = []
    var folders : [Folder] = []
    
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        if lhs.name != rhs.name {
            return false
        }
        return true
    }
}


