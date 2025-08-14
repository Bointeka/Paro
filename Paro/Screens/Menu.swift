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
    MenuView(folderModel: MenuView.testData(), passwordModel: Password.createPasswordModelHelper).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

extension MenuView {
    static func testData() -> FolderModel {
        return FolderModel(folders: [])
    }
}
