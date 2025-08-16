//
//  FolderSwipe.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//

import SwiftUI

struct FolderSwipe: View {
    @ObservedObject var selectedFolder: Folders
    @State var folder: Folders
    var body: some View {
        Button(role: .destructive) {
            if (selectedFolder.folders.isEmpty && selectedFolder.notes.isEmpty) {
                selectedFolder.deleteFolder(folder)
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
        Button {
            //TODO: Implement move folder
        } label: {
            Label("Move", systemImage: "folder.fill")
        }
    }
}

#Preview {
    FolderSwipe(selectedFolder: Folders.folderPreviewHelper, folder: Folders.folderPreviewHelper)
}
