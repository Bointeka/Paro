//
//  NewFolder.swift
//  Paro
//
//  Created by Jeremy Ok on 8/1/25.
//

import SwiftUI

struct AddFolder: View {
    
    @Binding var isPresented: Bool
    @Binding var folderModel: FolderModel?
    @Binding var folder: FolderDev?
    @Binding var passwords: [PasswordDev]
    
    @State var selectedPassword: PasswordDev? = nil
    @State var folderName: String = ""
    @State var showCreateAlert = false
    @State var lock = false
    @State var createPassword = false
    @State var newPassword: PasswordDev? = nil
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
                        if (folderModel != nil) {
                            do {
                                try folderModel?.addFolder(FolderDev(name: folderName, passwordHash: selectedPassword))
                                isPresented.toggle()
                            } catch {
                                showCreateAlert.toggle()
                            }
                        } else {
                            do {
                                try folder?.addFolder(FolderDev(name: folderName, passwordHash: selectedPassword))
                                isPresented.toggle()
                            } catch {
                                showCreateAlert.toggle()
                            }
                        }
                       
                        
                    } label: {
                        Text("Create")
                    }.padding(.horizontal, geo.size.width * 0.05)
                        .alert("There is already a folder with the same name.", isPresented: $showCreateAlert) {
                        }
                }.padding(.vertical, 10)
                TextField("Folder Name", text: $folderName)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    .textInputAutocapitalization(.words)
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
                                ForEach(passwords, id: \.self.id) { password in
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
        Spacer()
       
    }
}

#Preview {
    
    struct Preview: View {
        @State var password: [PasswordDev] = AddFolder.testData()
        var body: some View {
            AddFolder(isPresented: .constant(true as Bool), folderModel: .constant(FolderModel(folders:[])), folder: .constant(nil), passwords: $password)
        }
    }
    return Preview()
    
}

extension AddFolder {
    static func testData() -> [PasswordDev] {
        var passwords: [PasswordDev] = []
        do {
            let password = try PasswordDev(name: "test", password: "test", hint: "test")
            passwords.append(password)
        } catch {
            print(error)
        }
        
        return passwords
    }
}
