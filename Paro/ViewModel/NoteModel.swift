//
//  Note.swift
//  Paro
//
//  Created by Jeremy Ok on 7/4/25.
//

import SwiftUI

@Observable class NoteModel {
    var note : Note
    
    init(note: Note) {
        self.note = note
    }
}
