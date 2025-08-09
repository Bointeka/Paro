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
    @Binding var passwords: PasswordModel
    @State var unlock: Bool = false
    @State var folderCheck: Bool = true
    var body: some View {
        HStack {
            Text(folder.name)
            Spacer()
            if (folder.passwordHash != nil && folder.passwordHash!.locked == true) {
                Icon(iconName: "lock", width: 15, height: 15)
            } else if (folder.passwordHash != nil && folder.passwordHash!.locked == false) {
                Icon(iconName: "lock.open", width: 15, height: 15)
            }
        }.contentShape(Rectangle())
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
    
    static func testDataPasswords() -> PasswordModel{
        var passwords: PasswordModel = PasswordModel(passwords: [])
        try! passwords.addPassword(PasswordDev(name: "None"))
        return passwords
    }
}


