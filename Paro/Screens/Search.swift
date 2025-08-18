//
//  Search.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct Search: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    @State var searchString: String = ""
    @State var folders: [Folders] = []
    @State var notes: [Note] = []
    var body: some View {
        NavigationView {
            List {
                Section("Folders") {
                    ForEach(folders, id: \.self.name) { folder in
                        EntryFolder(folder: folder).transition(.opacity)
                    }
                }
                Section("Notes") {
                    ForEach(notes, id: \.self.timestamp) { note in
                        EntryNote(note: note, folder: note.folder ?? Folders(name: "empty", context: context), notes: .constant([])).transition(.opacity)
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                TextField("Search",text: $searchString)
                    .frame(width: 300, height: 50)
                    .onChange(of: searchString, initial: false) { oldValue, newValue in
                            folders = Folders.searchFolders(context: context, search: newValue)
                        notes = Note.searchNotes(context: context, search: newValue)
                    }.autocorrectionDisabled()
                , trailing:
                    Button {
                        searchString = ""
                        dismiss()
                    } label: {
                        Text("Cancel")
                    })
    }
}

#Preview {
    Search().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
