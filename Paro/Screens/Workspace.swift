//
//  Workspace.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct Workspace: View {
    @Environment(\.managedObjectContext) var context
    
    @Binding var passwords: PasswordModel
    @Binding var path: NavigationPath
    
    @State var isVisible: Bool = false
    @ObservedObject var selectedFolder: Folders
    @State var unlock: Bool = false
    @State var password: String = ""
    @State var blankModel: FolderModel = FolderModel(folders: [])
    @State var folders: [Folders] = []
    @State var notes: [Note] = []
    @State var isDeleteDialogPresented: Bool = false
    @State var selectedSubFolder: Folders? = nil
    
    var body: some View {
        List {
           Section(header: Text("Folders")) {
                ForEach(folders, id: \.self.index) { folder in
                    EntryFolder(folder: folder).swipeActions (edge: .trailing){
                       FolderSwipe(selectedFolder: selectedFolder, isDeleteDialogPresented: $isDeleteDialogPresented , folders: $folders, selectedSubFolder: $selectedSubFolder, folder: folder)
                    }.onTapGesture {
                        if (folder.passwordHash != nil && folder.passwordHash!.locked_){
                            unlock.toggle()
                        } else {
                            path.append(folder)
                        }
                        
                    }.alert("Unlock folder", isPresented: $unlock) {
                        SecureField("Password", text: $password).textInputAutocapitalization(.never)
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
            Section(header: Text("Notes")) {
                ForEach(notes, id: \.self.timestamp) { note in
                    EntryNote(note: note,folder: selectedFolder, notes: $notes).swipeActions(edge: .trailing) {
                        NoteSwipe(folder: selectedFolder, note: note, notes: $notes)
                    }
                }
            }
        }.navigationDestination(for: Folders.self) { folder in
            Workspace(passwords: $passwords, path: $path, selectedFolder: folder)
        }.toolbar(content: {
            ToolbarItem (placement: .topBarTrailing){
                NavigationLink(destination: Search(passwords: $passwords, path: $path)) {
                    Icon(iconName: "magnifyingglass", width: 25, height: 25)
                        .padding(.trailing, 30)
                }
            }
        }).onAppear() {
            folders = Folders.fetchSubFolders(context: context, folder: selectedFolder)
            notes = Note.fetchNotes(context: context, folder: selectedFolder)
        }
        HStack {
            Button {
                isVisible.toggle()
            } label: {
                Icon(iconName: "folder.fill.badge.plus", width: 50, height: 50)
                
            }.padding(.leading, 30)
            Spacer()
            if (!passwords.locked && selectedFolder.passwordHash != nil) {
                LockFolders(passwords: $passwords, path: $path, selectedFolder: selectedFolder)
            }
            Spacer()
            NavigationLink(destination: NoteEdit(folder: selectedFolder, note: Note(context: context), notes: $notes)) {
                Icon(iconName:"square.and.pencil", width: 40, height: 40)
            }.padding(.trailing, 30)
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: $blankModel, folder: selectedFolder, passwords: $passwords, folders: $folders)
        }.confirmationDialog("Delete this folder?", isPresented: $isDeleteDialogPresented) {
            Button("Delete", role: .destructive) {
                isDeleteDialogPresented = false
                
                DispatchQueue.main.async{
                    withAnimation() {
                        deleteFolder()
                    }
                    selectedSubFolder = nil
                }
                
                try! context.save()
            }
            Button("Cancel", role: .cancel) {
                selectedSubFolder = nil
            }
        } message: {
            Text("The folder and all its contents will be permanently removed.")
        }
    }
    
    func deleteFolder() {
        guard let folder = selectedSubFolder else { return }
        selectedFolder.deleteFolder(folder)
        withAnimation {
            if let index = folders.firstIndex(of: folder) {
                folders.remove(at: index)
            }
        }
        
    }
}

#Preview {
    
    struct WorkspacePreview: View {
        @State var passwords: PasswordModel = Password.createPasswordModelHelper
        @State var path: NavigationPath = NavigationPath()
        var body: some View {
            Workspace(passwords: $passwords, path: $path, selectedFolder: Folders.folderPreviewHelper)
        }
    }
    return WorkspacePreview().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    
}


extension Workspace {
    static func testDataFolder() -> FolderDev{
        return FolderDev(name: "test", passwordHash: nil)
    }
}
