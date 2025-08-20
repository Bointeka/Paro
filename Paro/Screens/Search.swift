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
    @Binding var passwords: PasswordModel
    @Binding var path: NavigationPath
    
    @State var searchString: String = ""
    @State var folders: [Folders] = []
    @State var notes: [Note] = []
    @State var unlock: Bool = false
    @State var password: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Folders") {
                    ForEach(folders, id: \.self.name) { folder in
                        EntryFolder(folder: folder).transition(.opacity)
                            .onTapGesture {
                            if (folder.passwordHash != nil && folder.passwordHash!.locked_){
                                unlock.toggle()
                            } else {
                                path.append(folder)
                            }
                            
                        }.alert("Unlock folder", isPresented: $unlock) {
                            SecureField("Password", text: $password)
                                .textInputAutocapitalization(.never)
                            HStack {
                                Button {
                                    if (folder.passwordHash != nil && folder.passwordHash!.unlock(password)) {
                                        unlock.toggle()
                                        password = ""
                                        passwords.locked = false
                                        path.append(folder)
                                        
                                    }
                                } label : {
                                    Text("Unlock")
                                }
                                Button {
                                    unlock.toggle()
                                } label : {
                                    Text("Cancel")
                                }
                            }
                        }
                    }
            }
                Section("Notes") {
                    ForEach(notes, id: \.self.timestamp) { note in
                        EntryNote(note: note, folder: note.folder ?? Folders(name: "empty", context: context), notes: .constant([])).transition(.opacity)
                    }
                }
            }.navigationDestination(for: Folders.self) { folder in
                Workspace(passwords: $passwords, path: $path, selectedFolder: folder)
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
    struct SearchPreview: View {
        @State var passwords: PasswordModel = PasswordModel(passwords: [])
        @State var path: NavigationPath = NavigationPath()
        
        var body: some View {
            Search(passwords: $passwords, path: $path)
        }
    }
    
    return SearchPreview().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
