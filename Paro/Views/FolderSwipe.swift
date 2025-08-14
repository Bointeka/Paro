//
//  FolderSwipe.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//

import SwiftUI

struct FolderSwipe: View {
    @Binding var selectedFolder: FolderDev
    @State var folder: FolderDev
    var body: some View {
        Button(role: .destructive) {
            selectedFolder.deleteFolder(folder)
        } label: {
            Label("Delete", systemImage: "trash")
        }
        Button {
            //TODO: Implement move folder
        } label: {
            Label("Move", systemImage: "folder.fill")
        }    }
}

#Preview {
    FolderSwipe(selectedFolder: .constant(FolderDev(name: "test", passwordHash: nil)), folder: FolderDev(name:"test", passwordHash: nil))
}
