//
//  Workspace.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct Workspace: View {
    @State var isVisible: Bool = false
    @State var selectedFolder: FolderDev
    @Binding var passwords: PasswordModel
    
    @State var path: NavigationPath = NavigationPath()
    @State var unlock: Bool = false
    @State var password: String = ""
    var body: some View {
        NavigationStack (path: $path){
            Spacer()
            List {
                Section(header: Text("Folders")) {
                    //TODO: Figure out why swift navigates back whenever button is pressed to navigate forward. Tried chat gpt suggestions
                    ForEach(selectedFolder.folders , id: \.self.id) { folder in
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
                            
                        }.onTapGesture {
                            if (folder.passwordHash != nil && folder.passwordHash!.locked){
                                unlock.toggle()
                            } else {
                                print(folder)
                                path.append(folder)
                            }
                            
                        }.alert("Unlock folder", isPresented: $unlock) {
                            TextField("Password", text: $password)
                            HStack {
                                Button {
                                    if (folder.passwordHash != nil && folder.passwordHash!.unlock(password)) {
                                        unlock.toggle()
                                        path.append(folder)
                                        password = ""
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
                }
            }.navigationDestination(for: FolderDev.self) { folder in
                Workspace(selectedFolder: folder, passwords: $passwords)
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
            }.toolbar(content: {
                ToolbarItem (placement: .topBarTrailing){
                    NavigationLink(destination: Search()) {
                        Icon(iconName: "magnifyingglass", width: 30, height: 30)
                            .padding(.trailing, 30)
                    }
                }
            })
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: .constant(nil), folder: $selectedFolder, passwords: $passwords)
        }
    }
}

#Preview {
    
    struct WorkspacePreview: View {
        @State var passwords: PasswordModel = Workspace.testDataPassword()
        @State var folder: FolderDev = Workspace.testDataFolder()
        var body: some View {
            Workspace(selectedFolder: folder, passwords: $passwords)
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
    
    static func testDataPassword() -> PasswordModel {
        var passwords: PasswordModel = PasswordModel(passwords: [])
        try! passwords.addPassword(PasswordDev(name: "None"))
        return passwords
    }
}
