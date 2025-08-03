//
//  EntryFolder.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct EntryFolder: View {
    @State var folder: Folder?
    var body: some View {
        NavigationLink (destination: Workspace(selectedFolder: $folder)) {
            HStack {
                Text(folder!.name)
                Spacer()
            }
        }
    }
}

#Preview {
    EntryFolder(folder: Folder(name: "test"))
}
