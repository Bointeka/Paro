//
//  Entry.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct EntryNote: View {
    @State var note: Note
    var body: some View {
        NavigationLink(destination: NoteEdit(folder: .constant(nil), note: note)) {
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
    EntryNote(note: Note(id: 1, title: "Yes"))
}
