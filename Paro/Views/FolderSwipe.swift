//
//  FolderSwipe.swift
//  Paro
//
//  Created by Jeremy Ok on 8/13/25.
//

import SwiftUI

struct FolderSwipe: View {
    @ObservedObject var selectedFolder: Folders
    
    @Binding var isDeleteDialogPresented: Bool
    @Binding var selectedSubFolder: Folders?
    
    @State var folder: Folders
    
    
    var body: some View {
        Button(role: .destructive) {
            if (folder.folders.isEmpty && folder.notes.isEmpty) {
                deleteFolder()
            } else {
                isDeleteDialogPresented = true
                selectedSubFolder = folder
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    
    func deleteFolder() {
        selectedFolder.deleteFolder(folder)
    }
}

#Preview {
    FolderSwipe(selectedFolder: Folders.folderPreviewHelper, isDeleteDialogPresented: .constant(true), selectedSubFolder: .constant(Folders.folderPreviewHelper), folder: Folders.folderPreviewHelper, )
}
