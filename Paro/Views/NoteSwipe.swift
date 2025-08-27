//
//  NoteSwipe.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//

import SwiftUI

struct NoteSwipe: View {
    @ObservedObject var folder: Folders
    @ObservedObject var note: Note
    
    var body: some View {
        Button(role: .destructive) {
            folder.deleteNote(note)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

#Preview {
    NoteSwipe(folder: Folders.folderPreviewHelper, note: Note.notePreviewHelper)
}
