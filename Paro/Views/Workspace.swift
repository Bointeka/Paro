//
//  Workspace.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct Workspace: View {
    @State var isVisible: Bool = false
    @Binding var selectedFolder: Folder?
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                Icon(iconName: "magnifyingglass", width: 30, height: 30)
                    .padding(.trailing, 30)
                Button {
                    print(selectedFolder!.folders)
                } label: {
                    Text("Test")
                }
            }
            Spacer()
            List(selectedFolder!.folders) { folder in
                EntryFolder(folder: folder)
            }
            HStack {
                Button {
                    isVisible.toggle()
                } label: {
                    Icon(iconName: "folder.fill.badge.plus", width: 50, height: 50)
                        
                }.padding(.leading, 30)
                Spacer()
                NavigationLink(destination: NoteEdit(note: Note(id: 1))) {
                    Icon(iconName:"square.and.pencil", width: 40, height: 40)
                }.padding(.trailing, 30)
            }
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: .constant(nil), folder: $selectedFolder)
        }
    }
}

#Preview {
    Workspace(selectedFolder: .constant(Folder(name: "test")))
}
