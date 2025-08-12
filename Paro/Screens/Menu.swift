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
    @State var passwords: [PasswordDev] = []
    @State var text: String = "testing"
    @State var folderModel: FolderModel? = FolderModel(folders: [])
    @State var passwordModel: PasswordModel = PasswordModel(passwords: [])
    @State var isVisible: Bool = false
    
    @State var searchBar: Bool = false
    @State var path: NavigationPath = NavigationPath()
    @State var searchText: String = ""
    @State var emptyFolder: FolderDev = FolderDev()
    @State var unlock: Bool = false
    @State var password: String = ""
    var body: some View {
        NavigationStack (path: $path){
            List(folderModel!.folders) {folder in
                EntryFolder(folder: folder, passwords: $passwordModel)
                    .onTapGesture {
                    if (folder.passwordHash != nil && folder.passwordHash!.locked){
                        unlock.toggle()
                    } else {
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
            }.navigationTitle("Folders")
            .navigationDestination(for: FolderDev.self) {
                    folder in
                Workspace(passwords: $passwordModel, path: $path, selectedFolder: folder )
                }
                .toolbar(content: {
                    ToolbarItem (placement: .topBarTrailing){
                        NavigationLink(destination: Search()) {
                            Icon(iconName: "magnifyingglass", width: 25, height: 25)
                                    .padding(.trailing, 20)
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
            }
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: $folderModel, folder: $emptyFolder, passwords: $passwordModel)
        }
    }
}


#Preview {
    MenuView(passwords: MenuView.testData().passwords, folderModel: MenuView.testData().folderModel).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

extension MenuView {
    static func testData() -> (passwords: [PasswordDev], folderModel: FolderModel) {
        var passwords: [PasswordDev] = []
        passwords.append(PasswordDev(name: "None"))
        var folderModel: FolderModel = .init(folders: [])
        return (passwords, folderModel)
    }
}
