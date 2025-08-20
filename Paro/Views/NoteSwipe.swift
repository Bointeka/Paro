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
    @Binding var notes: [Note]
    var body: some View {
        Button(role: .destructive) {
            folder.deleteNote(note)
            if let index = notes.firstIndex(of: note) {
                notes.remove(at: index)
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
        Button {
            //TODO: Implement lock note (Allow for no edits)
        } label: {
            Label("Move", systemImage: "lock.fill")
        }
    }
}

#Preview {
    NoteSwipe(folder: Folders.folderPreviewHelper, note: Note.notePreviewHelper, notes: .constant([]))
}
