//
//  Entry.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct EntryNote: View {
    @Binding var note: Note
    var body: some View {
        HStack{
            Text(note.title)
            Spacer()
            Icon(iconName: "chevron.right", width: 20, height: 20)
        }
    }
}

#Preview {
    EntryNote(note: .constant(Note(id: 1, title: "Yes")))
}
