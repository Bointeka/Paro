//
//  EntryFolder.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct EntryFolder: View {
    @State var folder: Folder
    var body: some View {
        HStack {
            Text(folder.name)
            Spacer()
            Icon(iconName:"chevron.right", width: 20, height: 20)
        }
    }
}

#Preview {
    EntryFolder(folder: Folder(name: "test"))
}
