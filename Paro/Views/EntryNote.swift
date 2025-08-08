//
//  Entry.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct EntryNote: View {
    @State var note: NoteDev
    @Binding var folder: FolderDev
    var body: some View {
        NavigationLink(destination: NoteEdit(folder: $folder, note: note)) {
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
    EntryNote(note: NoteDev(id: 1, title: "Yes"), folder: .constant(FolderDev()))
}
