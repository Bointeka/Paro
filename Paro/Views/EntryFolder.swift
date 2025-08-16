//
//  EntryFolder.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct EntryFolder: View {
    @ObservedObject var folder: Folders
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
    EntryFolder(folder: Folders.folderPreviewHelper)
}


