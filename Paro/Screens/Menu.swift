//
//  ContentView.swift
//  Paro
//
//  Created by Jeremy Ok on 7/3/25.
//

import SwiftUI
import CoreData

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var text: String = "testing"
    @State var isVisible: Bool = false
    @State var folderModel: FolderModel = FolderModel(folders: [])
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                Icon(iconName: "magnifyingglass", width: 30, height: 30)
                    .padding(.trailing, 30)
                
            }
            Spacer()
            HStack {
                Button {
                    isVisible = true
                } label: {
                    Icon(iconName: "folder.fill.badge.plus", width: 50, height: 50)
                        
                }.padding(.leading, 30)
                Spacer()
                NavigationLink(destination: NoteEdit(note: Note( title: "yes", text: "yo whatup", timestamp: Date()))) {
                    Icon(iconName:"square.and.pencil", width: 40, height: 40)
                }.padding(.trailing, 30)
            }
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: $folderModel)
        }
    }
}


#Preview {
    MenuView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
