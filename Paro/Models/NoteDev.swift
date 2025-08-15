//
//  Notre.swift
//  Paro
//
//  Created by Jeremy Ok on 7/26/25.
//
import Foundation
import CoreData

@Observable class NoteDev: Equatable, Identifiable {
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
    
    func getTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: timestamp)
    }
    
    func addReflection(_ text: String, context: NSManagedObjectContext) {
        if (text != "" ) {
            self.reflections.insert(Reflection(id: Int64(reflections.count), text: text, context: context), at: 0)
        }
    }
    
    func deleteReflection(_ reflection: Reflection) {
        if let index = self.reflections.firstIndex(where: {reflection.id == $0.id}) {
            self.reflections.remove(at: index)
        }
    }
    
    static func == (lhs: NoteDev, rhs: NoteDev) -> Bool {
        return lhs.id == rhs.id
    }
    
}
