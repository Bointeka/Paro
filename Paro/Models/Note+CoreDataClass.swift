//
//  Note+CoreDataClass.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    func getTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: timestamp)
    }
    
    func addReflection(_ text: String, context: NSManagedObjectContext) {
        if (text != "" ) {
            addToReflections_(Reflection(id: Int64(reflections.count), text: text, context: context))
            do {
                try context.save()
            } catch {
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteReflection(_ reflection: Reflection) {
        guard let context = reflection.managedObjectContext else { return }
        
        context.delete(reflection)
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
    
}
