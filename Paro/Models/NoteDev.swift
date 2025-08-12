//
//  Notre.swift
//  Paro
//
//  Created by Jeremy Ok on 7/26/25.
//
import Foundation

@Observable class NoteDev: Equatable, Identifiable {
    var id: Int
    var title: String
    var text: String
    var timestamp: Date
    var reflections: [ReflectionDev] = []
    
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
    
    func addReflection(_ reflection: ReflectionDev) {
        reflection.id = reflections.count
        if (reflection.text != "" ) {
            self.reflections.insert(reflection, at: 0)
        }
    }
    
    func deleteReflection(_ reflection: ReflectionDev) {
        if let index = self.reflections.firstIndex(where: {reflection.id == $0.id}) {
            self.reflections.remove(at: index)
        }
    }
    
    static func == (lhs: NoteDev, rhs: NoteDev) -> Bool {
        return lhs.id == rhs.id
    }
    
}
