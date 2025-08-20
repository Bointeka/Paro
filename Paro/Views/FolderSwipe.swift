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
    @Binding var folders: [Folders]
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
        Button {
            //TODO: Implement move folder
        } label: {
            Label("Move", systemImage: "folder.fill")
        }
    }
    
    func deleteFolder() {
        selectedFolder.deleteFolder(folder)
        if let index = folders.firstIndex(of: folder) {
            folders.remove(at: index)
        }
    }
}

#Preview {
    FolderSwipe(selectedFolder: Folders.folderPreviewHelper, isDeleteDialogPresented: .constant(true), folders: .constant([]), selectedSubFolder: .constant(Folders.folderPreviewHelper), folder: Folders.folderPreviewHelper, )
}
