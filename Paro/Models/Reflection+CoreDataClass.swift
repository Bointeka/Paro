//
//  Reflection+CoreDataClass.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//
//

import Foundation
import CoreData

@objc(Reflection)
public class Reflection: NSManagedObject {

    func getTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self.timestamp)
    }
    
    func isEven() -> Bool {
        if (self.id % 2 == 0) {
            return true
        } else {
            return false
        }
    }
}
