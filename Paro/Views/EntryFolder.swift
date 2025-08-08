//
//  EntryFolder.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct EntryFolder: View {
    @State var folder: FolderDev
    @State var password: String = ""
    @Binding var passwords: [PasswordDev]
    //TODO: Put the locked option on the password. Unlocking one unlocks all
    @State var unlock: Bool = false
    @State var folderCheck: Bool = true
    var body: some View {
        NavigationLink (destination: Workspace(selectedFolder: $folder, passwords: $passwords)) {
            HStack {
                Text(folder.name)
                Spacer()
                if (folder.passwordHash?.locked ?? false) {
                    Icon(iconName: "lock", width: 15, height: 15)
                } else {
                    Icon(iconName: "unlock", width: 15, height: 15)
                }
            }
        }.contentShape(Rectangle())
            .onTapGesture {
                if (folder.passwordHash?.locked ?? false) {
                    unlock.toggle()
                }
            }
        .alert("Unlock folder", isPresented: $unlock) {
            TextField("Password", text: $password)
            HStack {
                Button {
                    if (folder.passwordHash!.unlock(password)) {
                        unlock.toggle()
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

#Preview {
    
    EntryFolder(folder: EntryFolder.testData(), passwords: .constant(EntryFolder.testDataPasswords()))
}

extension EntryFolder {
    static func testData() -> FolderDev{
        var password: PasswordDev?
        do {
            password = try PasswordDev(name: "test", password: "test", hint: "test")
        } catch {
            print(error)
            password = nil
        }
        return FolderDev(name: "test", passwordHash: password)
    }
    
    static func testDataPasswords() -> [PasswordDev]{
        var passwords: [PasswordDev] = []
        passwords.append(PasswordDev(name: "None"))
        return passwords
    }
}


