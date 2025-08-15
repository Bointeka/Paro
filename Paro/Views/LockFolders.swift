//
//  LockNotes.swift
//  Paro
//
//  Created by Jeremy Ok on 8/14/25.
//

import SwiftUI

struct LockFolders: View {
    @Binding var passwords: PasswordModel
    @Binding var path: NavigationPath
    @Binding var selectedFolder: FolderDev
    
    var body: some View {
        HStack {
            Text("Lock Notes").padding(.vertical, -1)
            Icon(iconName: "lock.open", width: 15, height: 20)
        }.onTapGesture {
            if !passwords.locked {
                passwords.locked.toggle()
                if (selectedFolder.passwordHash != nil) {
                    path = NavigationPath()
                }
            }
            for password in passwords.passwords {
                password.lock()
            }
        }.transition(.opacity)
    }
}

#Preview {
    LockFolders(passwords: .constant(PasswordModel(passwords: [])), path: .constant(NavigationPath()), selectedFolder: .constant(FolderDev(name: "", passwordHash: nil)))
}
