//
//  Notre.swift
//  Paro
//
//  Created by Jeremy Ok on 7/26/25.
//
import Foundation

struct Note: Equatable {
    var title: String
    var text: String
    var timestamp: Date
    var reflections: [Reflection] = []
}
