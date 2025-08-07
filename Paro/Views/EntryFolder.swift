//
//  EntryFolder.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct EntryFolder: View {
    @State var folder: FolderDev?
    @Binding var passwords: [PasswordDev]
    var body: some View {
        NavigationLink (destination: Workspace(selectedFolder: $folder, passwords: $passwords)) {
            HStack {
                Text(folder!.name)
                Spacer()
                if (folder!.locked) {
                    Icon(iconName: "lock", width: 15, height: 15)
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


