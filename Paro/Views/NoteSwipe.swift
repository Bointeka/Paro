//
//  NoteSwipe.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//

import SwiftUI

struct NoteSwipe: View {
    @Binding var folder: FolderDev
    @State var note: NoteDev
    var body: some View {
        Button(role: .destructive) {
            folder.deleteNote(note)
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
    NoteSwipe(folder: FolderDev(name: "Test", passwordHash: nil), note: NoteDev(id: 1, title: "TEST"))
}
