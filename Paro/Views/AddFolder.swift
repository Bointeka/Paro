//
//  NewFolder.swift
//  Paro
//
//  Created by Jeremy Ok on 8/1/25.
//

import SwiftUI

struct AddFolder: View {
    
    @Environment(\.managedObjectContext) var context
    
    @Binding var isPresented: Bool
    @Binding var folderModel: FolderModel
    @ObservedObject var folder: Folders
    @Binding var passwords: PasswordModel
    
    @FocusState var focused: Bool
    @State var selectedPassword: Password? = nil
    @State var folderName: String = ""
    @State var showCreateAlert = false
    @State var lock = false
    @State var createPassword = false
    @State var alertMessage: String = ""
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                HStack {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("Cancel")
                    }.padding(.horizontal, geo.size.width * 0.05)
                    Spacer()
                    Button {
                        if (folder.name != "nil") {
                            do {
                                let newFolder = Folders(name: folderName, passwordHash: selectedPassword, context: context)
                                try folder.addFolder(newFolder)
                                isPresented.toggle()
                            } catch {
                                alertMessage = error.localizedDescription
                                showCreateAlert.toggle()
                            }
                        } else {
                            do {
                                try folderModel.addFolder(Folders(name: folderName, passwordHash: selectedPassword, context: context), context: context)
                                isPresented.toggle()
                            } catch {
                                alertMessage = error.localizedDescription
                                showCreateAlert.toggle()
                            }
                            
                        }
                       
                        
                    } label: {
                        Text("Create")
                    }.padding(.horizontal, geo.size.width * 0.05)
                        .alert(alertMessage, isPresented: $showCreateAlert) {
                        }
                }.padding(.vertical, 10)
                TextField("Folder Name", text: $folderName)
                    .autocorrectionDisabled()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    .textInputAutocapitalization(.words)
                    .contentShape(Rectangle())
                    .focused($focused)
                Toggle(isOn: $lock.animation()) {
                    Text("Lock Folder")
                }.padding(.horizontal, geo.size.width * 0.05)
                    .padding(.vertical, 5)
                if (lock) {
                    VStack{
                        Button {
                            createPassword.toggle()
                        } label: {
                            Text("Create Password")
                        }
                        List {
                            Section(header: Text("Passwords")) {
                                ForEach(passwords.passwords, id: \.self) { password in
                                    PasswordSelection(selectedPassword: $selectedPassword, password: password)
                                }
                            }
                        }.alert("Create Password", isPresented: $createPassword) {
                            CreatePassword(passwords: $passwords, createPasswordIsPresent: $createPassword)
                        }
                    }.transition(.opacity)
                    
                }
            }
            
        }.padding(.top, 20)
            .onAppear {
                focused = true
            }
        Spacer()
       
    }
}

#Preview {
    
    struct Preview: View {
        @State var password: PasswordModel = Password.createPasswordModelHelper
        @State var folders: [Folders] = []
        var body: some View {
            AddFolder(isPresented: .constant(true as Bool), folderModel: .constant(Folders.previewFolderModel), folder: Folders.folderPreviewHelper, passwords: $password)
        }
    }
    return Preview().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    
}
