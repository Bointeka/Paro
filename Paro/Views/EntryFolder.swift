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
    @State var unlock: Bool = false
    @State var folderCheck: Bool = true
    var body: some View {
        HStack {
            Text(folder.name)
            Spacer()
            if (folder.passwordHash != nil && folder.passwordHash!.locked_ == true) {
                Icon(iconName: "lock", width: 15, height: 15)
            } else if (folder.passwordHash != nil && folder.passwordHash!.locked_ == false) {
                Icon(iconName: "lock.open", width: 15, height: 15)
            }
        }.contentShape(Rectangle())
    }
}

#Preview {
    
    EntryFolder(folder: EntryFolder.testData())
}

extension EntryFolder {
    static func testData() -> FolderDev{
        let context = PersistenceController.preview.container.viewContext
        var password: Password?
        do {
            password = try Password(name: "test", password: "test", hint: "test", context: context)
        } catch {
            print(error)
            password = nil
        }
        return FolderDev(name: "test", passwordHash: password)
    }
}


