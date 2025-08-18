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
    @Binding var folders: [Folders]
    var body: some View {
        Button(role: .destructive) {
            if (selectedFolder.folders.isEmpty && selectedFolder.notes.isEmpty) {
                selectedFolder.deleteFolder(folder)
                if let index = folders.firstIndex(of: folder) {
                    folders.remove(at: index)
                }
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
    FolderSwipe(selectedFolder: Folders.folderPreviewHelper, folder: Folders.folderPreviewHelper, folders: .constant([]))
}
