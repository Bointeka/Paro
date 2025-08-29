//
//  ContentView.swift
//  Paro
//
//  Created by Jeremy Ok on 7/3/25.
//

import SwiftUI
import CoreData

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context
    @Environment(\.openURL) var openURL
    
    @State var folderModel: FolderModel = FolderModel(folders: [])
    @State var passwordModel: PasswordModel = PasswordModel(passwords: [])
    @State var isVisible: Bool = false
    
    @State var searchBar: Bool = false
    @State var path: NavigationPath = NavigationPath()
    @State var searchText: String = ""
    @State var emptyFolder: Folders
    @State var unlock: Bool = false
    @State var password: String = ""
    @State var selectedSubFolder: Folders? = nil
    @State var isDeleteDialogPresented: Bool = false
    
    var body: some View {
        NavigationStack (path: $path){
            List(folderModel.folders, id: \.self) { folder in
                EntryFolder(folder: folder).transition(.slide)
                    .swipeActions( edge: .trailing) {
                        Button(role: .destructive) {
                            if (folder.folders.isEmpty && folder.notes.isEmpty) {
                                selectedSubFolder = folder
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        deleteFolder()
                                    }
                                }
                                
                            } else {
                                selectedSubFolder = folder
                                isDeleteDialogPresented = true
                            }
                            
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }.onTapGesture {
                        if (folder.passwordHash != nil && folder.passwordHash!.locked_){
                            unlock.toggle()
                            selectedSubFolder = folder
                        } else {
                            path.append(folder)
                        }
                        
                    }
            }
            .navigationTitle("Folders")
            .navigationDestination(for: Folders.self) {
                folder in
                Workspace(passwords: $passwordModel, path: $path, selectedFolder: folder )
            }.toolbar(content: {
                ToolbarItem (placement: .topBarTrailing){
                    NavigationLink(destination: Search(passwords: $passwordModel, path: $path)) {
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
                if (!passwordModel.locked) {
                    LockFolders(passwords: passwordModel, path: $path, selectedFolder: emptyFolder)
                }
                Spacer()
                Button {
                    //TODO: Create donation account
                    if let url = URL(string: "https://www.apple.com") {
                                    openURL(url)
                                }
                } label: {
                    Icon(iconName: "heart.circle.fill", width: 50, height: 50)
                }
            }.onAppear {
                folderModel = Folders.fetchRootFolders(context: context)
                passwordModel = Password.fetchPasswords(context: context)
            }
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: $folderModel, folder: emptyFolder, passwords: $passwordModel)
        }.overlay {
            if unlock {
                UnlockFolder(passwords: $passwordModel, selectedFolder: $selectedSubFolder, unlock: $unlock, path: $path)
                    .transition(.opacity)
            }
        }.confirmationDialog("Delete this folder?", isPresented: $isDeleteDialogPresented) {
            Button("Delete", role: .destructive) {
                isDeleteDialogPresented = false
                DispatchQueue.main.async{
                    withAnimation() {
                        deleteFolder()
                    }
                    selectedSubFolder = nil
                }
            }
            Button("Cancel", role: .cancel) {
                selectedSubFolder = nil
            }
        } message: {
            Text("The folder and all its contents will be permanently removed.")
        }.animation(.easeIn, value: unlock)
    }
    
    func deleteFolder() {
        folderModel.deleteFolder(selectedSubFolder!)
        try! context.save()
    }
}


#Preview {
    
    struct MenuViewPreview: View {
        @ObservedObject var emptyFolder: Folders = Folders(entity: Folders.entity(), insertInto: nil)
        var body: some View {
            MenuView(folderModel: MenuView.testData(), passwordModel: Password.createPasswordModelHelper, emptyFolder: emptyFolder)
        }
    }
    return MenuViewPreview().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    
    
}

extension MenuView {
    static func testData() -> FolderModel {
        return FolderModel(folders: [])
    }
}
