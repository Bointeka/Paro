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
    
    @State var folderModel: FolderModel = FolderModel(folders: [])
    @State var passwordModel: PasswordModel = PasswordModel(passwords: [])
    @State var isVisible: Bool = false
    
    @State var searchBar: Bool = false
    @State var path: NavigationPath = NavigationPath()
    @State var searchText: String = ""
    @State var emptyFolder: Folders
    @State var unlock: Bool = false
    @State var password: String = ""
    var body: some View {
        NavigationStack (path: $path){
            List(folderModel.folders) { folder in
                EntryFolder(folder: folder)
                    .onTapGesture {
                        if (folder.passwordHash != nil && folder.passwordHash!.locked_){
                            unlock.toggle()
                        } else {
                            path.append(folder)
                        }
                        
                    }.alert("Unlock folder", isPresented: $unlock) {
                        SecureField("Password", text: $password)
                        HStack {
                            Button {
                                if (folder.passwordHash != nil && folder.passwordHash!.unlock(password)) {
                                    unlock.toggle()
                                    password = ""
                                    passwordModel.locked = false
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
                .navigationTitle("Folders")
                .navigationDestination(for: Folders.self) {
                    folder in
                    Workspace(passwords: $passwordModel, path: $path, selectedFolder: folder )
                }.toolbar(content: {
                    ToolbarItem (placement: .topBarTrailing){
                        NavigationLink(destination: Search()) {
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
                    LockFolders(passwords: $passwordModel, path: $path, selectedFolder: emptyFolder)
                }
                Spacer()
                Text("Donate").padding(.trailing, 30)
            }
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: $folderModel, folder: emptyFolder, passwords: $passwordModel, folders: .constant([]))
        }.onAppear() {
            folderModel = Folders.fetchRootFolders(context: context)
            passwordModel = Password.fetchPasswords(context: context)
        }
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
