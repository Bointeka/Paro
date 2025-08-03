//
//  Notre.swift
//  Paro
//
//  Created by Jeremy Ok on 7/26/25.
//
import Foundation

struct Note: Equatable, Identifiable {
    var id: Int
    var title: String
    var text: String
    var timestamp: Date
    var reflections: [Reflection] = []
    
    init (id: Int) {
        self.id = id
        self.title = ""
        self.text = ""
        self.timestamp = Date.init()
    }
    
    init (id: Int, title: String) {
        self.id = id
        self.title = title
        self.text = ""
        self.timestamp = Date.init()
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
    
}
