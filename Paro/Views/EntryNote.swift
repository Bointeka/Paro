//
//  Entry.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct EntryNote: View {
    @ObservedObject var note: Note
    @ObservedObject var folder: Folders
    @Binding var notes: [Note]
    var body: some View {
        NavigationLink(destination: NoteEdit(folder: folder, note: note, notes: $notes)) {
            VStack {
                Text(note.title)
                Text(note.getTimestamp())
                    .font(.footnote)
            }
            
            Spacer()
        }
    }
}

#Preview {
    EntryNote(note: Note.notePreviewHelper, folder: Folders.folderPreviewHelper, notes: .constant([]))
}
