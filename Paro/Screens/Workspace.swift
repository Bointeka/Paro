//
//  Workspace.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct Workspace: View {
    @State var isVisible: Bool = false
    @Binding var selectedFolder: FolderDev
    @Binding var passwords: [PasswordDev]
    var body: some View {
        NavigationStack {
            Spacer()
            List {
                Section(header: Text("Folders")) {
                    ForEach(selectedFolder.folders) { folder in
                        EntryFolder(folder: folder, passwords: $passwords).swipeActions (edge: .trailing){
                            Button(role: .destructive) {
                                selectedFolder.deleteFolder(folder)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            Button {
                                //TODO: Implement move folder
                            } label: {
                                Label("Move", systemImage: "folder.fill")
                            }
                            
                        }
                    }
                }
                Section(header: Text("Notes")) {
                    ForEach(selectedFolder.notes) { note in
                        EntryNote(note: note,folder: $selectedFolder).swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                selectedFolder.deleteNote(note)
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
                }.toolbar(content: {
                    ToolbarItem (placement: .topBarTrailing){
                        NavigationLink(destination: Search()) {
                            Icon(iconName: "magnifyingglass", width: 30, height: 30)
                                .padding(.trailing, 30)
                        }
                    }
                })
            }
            HStack {
                Button {
                    isVisible.toggle()
                } label: {
                    Icon(iconName: "folder.fill.badge.plus", width: 50, height: 50)
                    
                }.padding(.leading, 30)
                Spacer()
                NavigationLink(destination: NoteEdit(folder: $selectedFolder, note: NoteDev(id: 1))) {
                    Icon(iconName:"square.and.pencil", width: 40, height: 40)
                }.padding(.trailing, 30)
            }
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: .constant(nil), folder: $selectedFolder, passwords: $passwords)
        }
    }
}

#Preview {
    
    struct WorkspacePreview: View {
        @State var passwords: [PasswordDev] = Workspace.testDataPassword()
        @State var folder: FolderDev = Workspace.testDataFolder()
        var body: some View {
            Workspace(selectedFolder: $folder, passwords: $passwords)
        }
    }
    return WorkspacePreview()
    
}


extension Workspace {
    static func testDataFolder() -> FolderDev{
        var password: PasswordDev?
        do {
            password = try PasswordDev(name: "test", password: "test", hint: "test")
        } catch {
            print(error)
            password = nil
        }
        return FolderDev(name: "test", passwordHash: password)
    }
    
    static func testDataPassword() -> [PasswordDev] {
        var passwords: [PasswordDev] = []
        passwords.append(PasswordDev(name: "None"))
        return passwords
    }
}
