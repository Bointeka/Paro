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
    @State var blankModel: FolderModel = FolderModel(folders: [])
    @State var isDeleteDialogPresented: Bool = false
    @State var selectedSubFolder: Folders? = nil
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Folders")) {
                    ForEach(Array(selectedFolder.folders).sorted(by: { $0.index < $1.index}), id: \.self.index) { folder in
                        EntryFolder(folder: folder).swipeActions (edge: .trailing){
                            FolderSwipe(selectedFolder: selectedFolder, isDeleteDialogPresented: $isDeleteDialogPresented, selectedSubFolder: $selectedSubFolder, folder: folder)
                        }.onTapGesture {
                            if (folder.passwordHash != nil && folder.passwordHash!.locked_){
                                unlock.toggle()
                                selectedSubFolder = folder
                            } else {
                                path.append(folder)
                            }
                            
                        }
                    }
                }
                Section(header: Text("Notes")) {
                    ForEach(Array(selectedFolder.notes).sorted(by: {$0.timestamp > $1.timestamp}), id: \.self.timestamp) { note in
                        EntryNote(note: note,folder: selectedFolder).swipeActions(edge: .trailing) {
                            NoteSwipe(folder: selectedFolder, note: note)
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
            })
            HStack {
                Button {
                    isVisible.toggle()
                } label: {
                    Icon(iconName: "folder.fill.badge.plus", width: 50, height: 50)
                    
                }.padding(.leading, 30)
                Spacer()
                if (!passwords.locked && selectedFolder.passwordHash != nil) {
                    LockFolders(passwords: passwords, path: $path, selectedFolder: selectedFolder)
                }
                Spacer()
                NavigationLink(destination: NoteEdit(folder: selectedFolder, note: Note(context: context))) {
                    Icon(iconName:"square.and.pencil", width: 40, height: 40)
                }.padding(.trailing, 30)
            }.sheet(isPresented: $isVisible) {
                AddFolder(isPresented: $isVisible, folderModel: $blankModel, folder: selectedFolder, passwords: $passwords)
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
            
        }.overlay {
            if unlock {
                UnlockFolder(passwords: $passwords, selectedFolder: $selectedSubFolder, unlock: $unlock, path: $path)
                    .transition(.opacity)
            }
        }.animation(.easeIn, value: unlock)
    }
    
    func deleteFolder() {
        guard let folder = selectedSubFolder else { return }
        selectedFolder.deleteFolder(folder)
        
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
