//
//  Reflection.swift
//  Paro
//
//  Created by Jeremy Ok on 7/31/25.
//

import Foundation

@Observable class ReflectionDev {
    var id: Int
    var timestamp: Date
    var text: String
    
    init() {
        self.id = 0
        self.text = ""
        self.timestamp = Date()
    }
    
    init(id: Int) {
        self.id = id
        self.text = ""
        self.timestamp = Date()
    }
    
    init(text: String) {
        self.id = 0
        self.text = text
        self.timestamp = Date()
    }
    
    func getTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: timestamp)
    }
    
    func isEven() -> Bool {
        if (id % 2 == 0) {
            return true
        } else {
            return false
        }
    }
}
