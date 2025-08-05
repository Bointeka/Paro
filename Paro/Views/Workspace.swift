//
//  Workspace.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct Workspace: View {
    @State var isVisible: Bool = false
    @Binding var selectedFolder: FolderDev?
    var body: some View {
        NavigationStack {
            Spacer()
            List {
                Section(header: Text("Folders")) {
                    ForEach(selectedFolder!.folders) { folder in
                        EntryFolder(folder: folder)
                    }
                }
                Section(header: Text("Notes")) {
                    ForEach(selectedFolder!.notes) { note in
                        EntryNote(note: note)
                    }
                }
            }.toolbar(content: {
                ToolbarItem (placement: .topBarTrailing){
                    NavigationLink(destination: Search()) {
                        Icon(iconName: "magnifyingglass", width: 30, height: 30)
                                .padding(.trailing, 30)
                    }
                }
            })
            HStack {
                Button {
                    isVisible.toggle()
                } label: {
                    Icon(iconName: "folder.fill.badge.plus", width: 50, height: 50)
                        
                }.padding(.leading, 30)
                Spacer()
                NavigationLink(destination: NoteEdit(folder: $selectedFolder, note: NoteDev(id: 1))) {
                    Icon(iconName:"square.and.pencil", width: 40, height: 40)
                }.padding(.trailing, 30)
            }
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: .constant(nil), folder: $selectedFolder)
        }
    }
}

#Preview {
    Workspace(selectedFolder: .constant(FolderDev(name: "test")))
}
